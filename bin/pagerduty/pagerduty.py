"""
This script is used to generate information around how often users are on call on holidays.
It hits the Pagerduty schedules API to retrieve oncall information, and relies
on holiday and user data from a separate file.

The output format is a list of user information of the form:
[{
    "name": "User Name",

    # number of holidays on call between date range. If there are two holidays in one oncall week
    # both holidays will be counted. If WEIGHTED is True, weights are added to certain holidays.
    "holidays_on_call": 1,

    # number of days since this user joined the team, until the end date specified
    "days_on_team": 249,

    # the number of holidays this user has been on call based on the
    # number of years (decimal number) the person has been on the team.
    # If a user has been on call 1 holiday and has been on the team for 6 months, they'd have
    # a frequency of 1 day / 0.5 years = 2 holidays_on_call_per_years_on_team
    "holidays_on_call_per_years_on_team": 1.47
}]

NOTE:
The frequency metric likely isn't the best number to determine oncall scheduling
from, primarily since some holidays can be considered "more important" then others.
Ex: most people would rather be on call over a day of rest than Christmas.
The WEIGHTED arg tries to fix this, but isn't perfect. Everyone's perception of importance is 
different.

It also doesn't consider new members to the team, they likely shouldn't be oncall
over a holiday their first couple times.

Required packages:
  https://docs.python-requests.org/en/latest/user/install/#install

pip install necessary packages, create a pagerduty API user token through User Settings, and then run:

  python3 pagerduty.py --api_key <api_key>
  python3 pagerduty.py --api_key <api_key> --weighted
  python3 pagerduty.py -a <api_key> -w -e <end_date>
"""

import argparse
import datetime
import json
import sys

from holidays import holidays
import requests
from users import users


# Date range to search
FIRST_USER_START_DATE = "2019-09-09"
END_DATE = "2023-01-02"

SCHEDULE_ID = "dummy"


def get_schedules(since, until, schedule_id, auth_token):
  """
  Fetches on call schedule information between the specified dates (inclusive)
  API Info: https://developer.pagerduty.com/api-reference/reference/REST/openapiv3.json/paths/~1schedules/get

  :param since: starting date to search
  :param until: last date to search
  :param schedule_id: the pagerduty id of the schedule to search
  :param auth_token: auth token required for API call
  :return: daily on call schedule information
  """
  url = f"""https://api.pagerduty.com/schedules/{schedule_id}?since={since}&until={until}
          &time_zone=America/Los_Angeles"""

  headers = {
    "Accept": "application/vnd.pagerduty+json;version=2",
    "Content-Type": "application/json",
    "Authorization": f"Token token={auth_token}",
  }

  response = requests.request("GET", url, headers=headers)
  status_code = response.status_code
  if status_code != 200:
    if status_code == 400:
      print("Invalid API arguments")
    elif status_code == 401:
      print("Invalid API Key")
    elif status_code == 403:
      print("Unauthorized user")
    elif status_code == 429:
      print("Rate limited")
    sys.exit(f"Check pagerduty API docs for more info on status code: {status_code}")

  response_body = json.loads(response.text)

  return response_body["schedule"]["final_schedule"]["rendered_schedule_entries"]


def get_users_map():
  """
  Get user data keyed off user name

  :return: map of user data keyed by user name
  """
  users_map = {}
  # users is imported
  for user in users:
    user_name = user["name"]
    users_map[user_name] = user

  return users_map


def count_holidays(schedule_entries, user_names, weighted):
  """
  Count the number of holidays a user has been on call

  :param schedule_entries: Daily oncall schedule entries
  :param user_names: Names of users to count
  :return: map from name to number of holidays on call
  """
  holidays_by_name = {}
  for name in user_names:
    holidays_by_name[name] = 0

  for entry in schedule_entries:
    name = entry["user"]["summary"]
    if name not in holidays_by_name:
      continue

    start_date = datetime.datetime.fromisoformat(entry["start"]).date()
    end_date = datetime.datetime.fromisoformat(entry["end"]).date()
    step = datetime.timedelta(days=1)

    # loop over dates, checking if the current date is a holiday
    while start_date <= end_date:
      start_formatted = start_date.isoformat()
      if start_formatted in holidays:
        increment = holidays[start_formatted] if weighted else 1
        holidays_by_name[name] += increment

      start_date += step

  return holidays_by_name


def generate_user_data(holidays_by_name, users_map, until):
  """
  Generates more data about users oncall holiday frequency

  :param holidays_by_name: Map from name to number of holidays on call
  :param users_map: map from user name to information about the user
  :param until: last date to search, used to determine days on team up to that date
  :return: data for each users oncall holiday frequency
  """
  user_data = []

  last_date = datetime.date.fromisoformat(until)
  for name, holidays_for_name in holidays_by_name.items():
    if name in users_map:
      team_start_date = datetime.date.fromisoformat(users_map[name]["team_start_date"])
      days_on_team = (last_date - team_start_date).days
      years_on_team = days_on_team / 365
      holiday_freq = round(holidays_for_name / years_on_team, 2)
      user_data.append(
        {
          "name": name,
          "holidays_on_call": holidays_for_name,
          "days_on_team": days_on_team,
          "holidays_on_call_per_years_on_team": holiday_freq,
        }
      )

  return user_data


def argparse_setup():
  parser = argparse.ArgumentParser(
    prog="pagerduty",
    description="Tool used to generate information around how often users are on call on "
    "holidays. See pagerduty.py for more information.",
  )

  parser.add_argument("--api_key", "-a", help="Pagerduty API key", required=True)
  parser.add_argument(
    "--weighted", "-w", action="store_true", help="Include weights in holiday counting"
  )
  parser.add_argument(
    "--end_date",
    "-e",
    help="The end date for searching the pagerduty schedule/counting team member tenure",
    default=END_DATE,
  )

  return parser.parse_args()


def main():
  args = argparse_setup()

  user_api_key = args.api_key
  end_date = args.end_date
  weighted = args.weighted

  schedule_entries = get_schedules(FIRST_USER_START_DATE, end_date, SCHEDULE_ID, user_api_key)
  users_map = get_users_map()
  holidays_by_name = count_holidays(schedule_entries, users_map.keys(), weighted)
  user_data = generate_user_data(holidays_by_name, users_map, end_date)

  sorted_user_data = sorted(
    user_data, key=lambda user: user["holidays_on_call_per_years_on_team"], reverse=True
  )
  print(json.dumps(sorted_user_data, indent=4))


if __name__ == "__main__":
  main()
