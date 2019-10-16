#!/bin/bash

readonly scilla_runner="${SCILLA_DIR}/bin/scilla-runner"
readonly scilla_checker="${SCILLA_DIR}/bin/scilla-checker"
readonly scilla_libdir="${SCILLA_DIR}/src/stdlib"

if [[ -z ${SCILLA_DIR} || ! -x ${scilla_runner} || ! -x ${scilla_checker} || ! -d ${scilla_libdir} ]]
then
    echo "Scilla library / binaries not found. Please set SCILLA_DIR correctly."
    exit 1
fi

function print_usage_and_exit
{
    echo "Usage: $0 [llength|lsum|lunzip]"
    exit 1
}

if [[ ! -f state.json || ! -f init.json || ! -f blockchain.json || ! -f list_learning.scilla ||
          ! -f message_llength.json || ! -f message_lsum.json || ! -f message_lunzip.json ]]
then
    echo "Missing Scilla contract / supporting JSONs"
    exit 1
fi

op=$1

if [[ $op != "llength" && $op != "lsum" && $op != "lunzip" ]]
then
    print_usage_and_exit
fi

${scilla_checker} -libdir ${scilla_libdir} -gaslimit 8000 list_learning.scilla
status=$?

if test $status -ne 0
then
    echo "scilla-checker failed"
    print_usage_and_exit
fi

${scilla_runner} -init init.json -istate state.json -imessage message_${op}.json -o output.json -iblockchain blockchain.json -i list_learning.scilla -gaslimit 8000 -libdir ${scilla_libdir}

status=$?

if test $status -eq 0
then
    echo "output.json emitted by interpreter:"
    cat output.json
    echo ""
else
    echo "scilla-runner failed"
    print_usage_and_exit
fi
