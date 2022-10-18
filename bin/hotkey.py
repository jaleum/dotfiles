"""
This script is used to aggregate the data output by the database hot key
console. It only works for datasets that have a long as the pkey.

It hits the hot key console API to fetch the hot keys, but also has a function
to read from a json file if the API isn't working.

The output is a map from pkey to count of the number of times that pkey was
flagged as a hotkey for reads and writes, sorted by count.

Required packages:
  https://docs.python-requests.org/en/latest/user/install/#install

pip install necessary packages and then run:

  python3 hotkey.py api -s <start_time> -e <end_time> -a <app_id>
  python3 hotkey.py file <filename>

"""
import argparse
import json
import requests
import sys

from collections import defaultdict
from datetime import datetime, timezone

# The application id to search
APP_ID = "dummyghj"

# Example date range to search, in UTC
SINCE = "2021-07-11T05:00:00"
UNTIL = "2021-07-12T05:00:00"

# if the API isn't working, grab the json response from the Chrome dev tools 
# network tab, add it to a file and use get_hotkeys_file()
HOTKEY_FILE = 'hotkey.json'

def timestamp(dt):
    """
    Converts a UTC date time into a timestamp in milliseconds
    """
    return datetime.fromisoformat(dt).replace(tzinfo=timezone.utc).timestamp() * 1000


def get_hotkeys_api(args):
    """
    Fetches hotkeys of an application between the specified time.
    """
    app_id = args.app_id
    since_ts = timestamp(args.start_time)
    until_ts = timestamp(args.end_time)

    if until_ts <= since_ts:
        raise ValueError("start_time must be before end_time")

    url = ()

    headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }

    response = requests.request("GET", url, headers=headers)
    status_code = response.status_code
    if status_code != 200:
        sys.exit("Failed to fetch from api with status code: " + str(status_code))

    response_body = json.loads(response.text)

    return response_body["Result"]

def get_hotkeys_file(args):
    with open(args.filename) as f:
        data = json.load(f)

        return data["Result"]


def pretty_print(d):
    sorted_dict = dict(sorted(d.items(), key=lambda kv: kv[1], reverse=True))
    print(json.dumps(sorted_dict, indent=4))

def argparse_setup():
    parser = argparse.ArgumentParser(prog="hotkey",
        description="Tool used to print out hotkey information for a given application "
                    "over a period of time. Input data can be parsed from a file using the "
                    "'file' subcommand or the API using the 'api' subcommand.")
    subparsers = parser.add_subparsers(help="available commands")

    from_file_parser = subparsers.add_parser("file",
        help="Parse hotkey information from a JSON file.")
    from_file_parser.add_argument("filename", type=str, help="filename to parse")
    from_file_parser.set_defaults(func=get_hotkeys_file)

    from_api_parser = subparsers.add_parser("api",
        help="Parse hotkey information from the API. NOTE: Timestamps are UTC.")
    from_api_parser.add_argument("--app_id", "-a", type=str, default=APP_ID,
        help="APP ID")
    from_api_parser.add_argument("--start_time", "-s", type=str, required=True,
        help="start datetime ISO-8601 format, e.g. 2021-07-11T05:00:00, must be before end_time")
    from_api_parser.add_argument("--end_time", "-e", type=str, required=True,
        help="end datetime ISO-8601 format, e.g. 2021-07-11T05:00:00, must be after start_time")
    from_api_parser.set_defaults(func=get_hotkeys_api)

    args = parser.parse_args()

    try:
        args.func
    except AttributeError:
        parser.error("too few arguments")
    return args

def main():
    args = argparse_setup()
    results = args.func(args)

    read_by_user_id = defaultdict(int)
    write_by_user_id = defaultdict(int)
    for result in results:
        hot_keys = result["hotKeys"]
        if len(hot_keys) > 1:
            sys.exit("multiple hotkeys")

        hot_key = hot_keys[0]
        userId = hot_key["pKeyHex"]
        if hot_key["eventualRead"] > 0:
            read_by_user_id[userId] += 1
        if hot_key["eventualWrite"] > 0:
            write_by_user_id[userId] += 1

    print("read hotkeys: ")
    pretty_print(read_by_user_id)
    print("write hotkeys: ")
    pretty_print(write_by_user_id)


if __name__ == "__main__":
    main()

