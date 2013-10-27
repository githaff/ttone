#!/bin/sh

######################## Test initialization ########################

TEST_NAME="Reveal command test"

SCRIPT_DIR="$(readlink -f $(dirname ${0}))"
TRUT="${SCRIPT_DIR}/../bin/trut"

source "${SCRIPT_DIR}/common.sh"
source "${SCRIPT_DIR}/functions.sh"

test_init $@


############################# Test body #############################


############################# Test exit #############################

test_finalize
