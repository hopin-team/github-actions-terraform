#!/bin/bash +e

tfsec --format=checkstyle -e AWS045 | reviewdog -f=checkstyle -name="tfsec" -reporter=github-pr-review

tfsec_return="${PIPESTATUS[0]}" reviewdog_return="${PIPESTATUS[1]}" exit_code=$?

exit $exit_code
