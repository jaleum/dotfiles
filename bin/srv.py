#!/usr/bin/python3

"""
This script accepts a job name as a single parameter and outputs the service name for the job.

Ex:
$ srv test
test.staging.test

"""

from enum import Enum
import re
import sys

# helper enum for support env types
class Env(Enum):
    STAGING = "staging"
    DEVEL = "devel"
    NONE = "none"


# helper object to hold the service role and job patterns
class EnvMatcher:
    def __init__(self, role, staging_pattern, devel_pattern):
        self.role = role
        self.staging_pattern = staging_pattern
        self.devel_pattern = devel_pattern


# regex match to determine env type
def get_env(env_matcher, job):
    if re.match(env_matcher.staging_pattern, job):
        return Env.STAGING
    elif re.match(env_matcher.devel_pattern, job):
        return Env.DEVEL

    return Env.NONE


# setup env matchers
test = "test"
env_matchers = [
    EnvMatcher(test, f"^{test}$", f"^.*{test}$"),
]

if len(sys.argv) != 2:
    sys.exit("Invalid arguments, expected single job name argument")

job = sys.argv[1]

if re.match(".*prod.*", job):
    print("Prod job, proceeding with it as is", file=sys.stderr)
    print(job)
    sys.exit()

env = Env.NONE
service = ""
for matcher in env_matchers:
    env = get_env(matcher, job)
    if env != Env.NONE:
        service = f"{matcher.role}.{env.value}.{job}"
        break

if env == Env.NONE:
    service = job
    print(f"Unknown job: {job}, proceeding with it as service", file=sys.stderr)

print(service)
