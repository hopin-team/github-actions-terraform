#!/bin/bash +e

_FILES=$(printf '%s' "$1" | jq -r '.[]')

_EXIT_CODE="0"

_TFLINT_HCL_PATH="$2"

if [[ -f ".tflint.hcl" ]]; then
  _TFLINT_HCL_PATH=".tflint.hcl"
fi

for _FILE in $_FILES
do
  if [ "${_FILE: -3}" == ".tf" ]; then
    echo "Checking file: $_FILE"

    if ! tflint -f checkstyle "$_FILE" -c "$_TFLINT_HCL_PATH" > _TFLINT; then
      _EXIT_CODE="1"
    fi

    cat _TFLINT

    cat _TFLINT | reviewdog -f=checkstyle -name="tflint" -reporter=github-pr-review
  fi
done

exit $_EXIT_CODE
