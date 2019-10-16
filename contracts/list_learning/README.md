# List Learning

## Introduction
This directory provides a skeleton contract for learning to
write the following list functions

1. `list_length`: compute the number of elements in a list
2. `list_sum`: compute the sum of elements of an integer list
3. `list_unzip`: convert a list of pairs into a pair of lists

Consequently, three placeholder functions for these three are
defined in the library section of `list_learning.scilla`. These
are to be filled up by the participant.

## Running
An easy runner script is provided. `easyrun.sh` expects the
user to have already set the environment variable SCILLA_DIR
pointing to a scilla build. For example `export SCILLA_DIR=/path/to/scilla`.

The script can be used as follows:

1. `./easyrun.sh llength`. This will execute the list_length
  function with inputs taken from `message_llength.json`
2. `./easyrun.sh lsum`. This will execute the list_sum
  function with inputs taken from `message_lsum.json`
3. `./easyrun.sh lunzip`. This will execute the list_unzip
  function with inputs taken from `message_lunzip.json`
