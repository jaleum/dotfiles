"""
Holidays since the earliest team member was on call, with approximate weights for the holidays.

These weights are by no means perfect, and can be adjusted as you see fit. They are mostly a
reflection of how often folks take time off around these holidays, and how often the general
population outside of Twitter has these days off.

Rough guide:
  Christmas, New Years, Thanksgiving (and their eves), Independence, Labor, Memorial, MLK: 2
  Other holidays: 1.5
"""
key_holiday = 2
other_holiday = 1.5
holidays = {
  "2019-12-31": key_holiday,
  "2020-01-01": key_holiday,
  "2020-01-20": key_holiday,
  "2020-02-17": other_holiday,
  "2020-05-25": key_holiday,
  "2020-06-19": other_holiday,
  "2020-07-03": key_holiday,
  "2020-09-07": key_holiday,
  "2020-11-03": other_holiday,
  "2020-11-26": key_holiday,
  "2020-11-27": key_holiday,
  "2020-12-24": key_holiday,
  "2020-12-25": key_holiday,
  "2020-12-31": key_holiday,
  "2021-01-01": key_holiday,
  "2021-01-18": key_holiday,
  "2021-02-15": other_holiday,
  "2021-05-31": key_holiday,
  "2021-06-18": other_holiday,
  "2021-07-05": key_holiday,
  "2021-09-06": key_holiday,
  "2021-11-11": other_holiday,
  "2021-11-25": key_holiday,
  "2021-11-26": key_holiday,
  "2021-12-24": key_holiday,
  "2021-12-27": key_holiday,
  "2021-12-31": key_holiday,
  "2022-01-03": key_holiday,
  "2022-01-17": key_holiday,
  "2022-02-21": other_holiday,
  "2022-05-30": key_holiday,
  "2022-06-20": other_holiday,
  "2022-07-04": key_holiday,
  "2022-09-05": key_holiday,
  "2022-10-10": other_holiday,
  "2022-11-11": other_holiday,
  "2022-11-24": key_holiday,
  "2022-11-25": key_holiday,
  "2022-12-23": key_holiday,
  "2022-12-26": key_holiday,
  "2022-12-30": key_holiday,
  "2023-01-02": key_holiday,
}
