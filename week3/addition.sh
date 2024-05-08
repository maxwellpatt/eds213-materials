#!/bin/bash

first=$1
second=$2
echo "The sum of $first and $second is $(($first+$second))"

# duckdb -csv database.db "SELECT Code, Common_name FROM Species"