#! /usr/bin/env bash     
# the previous statement indicates to interpret this program using bash

#set -x  #uncomment for execution logging - try it

TARPGM=tar

rm -rf dst
mkdir dst
(cd src; $TARPGM c *) | (cd dst;  tar x)
if diff -r src dst
then
    echo "success" >&2		# error msg to stdout
    rm -rf dst			# clean up
    exit 0			# return success
else
    echo "failure" >&2
    exit 1			# return failure
fi
     

