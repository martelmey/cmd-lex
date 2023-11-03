#!/bin/bash

sudo su - root
cd /export/pkgs/ops-tools
scp * martel.meyers@192.168.160.10:/export/ops-tools/ > ~/scp_ops-tools_result
declare -a FAILED=(

)
declare -a FAIL_MESSAGE=(
    "Could not" # delim is $FILE_TYPES: (<*.zip>:)
    "not a regular file" # delim is a colon (<folder_name>:)
)
declare -a FILE_TYPES(
    ".zip"
    ".exe"
    ".msi"
)
# Each line in scp_ops-tools_result
# matching a FAIL_MESSAGE, extract
# filename w/ delim based on FAIL_MESSAGE
# += FAILED, iterate scp over