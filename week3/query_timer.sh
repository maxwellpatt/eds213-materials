#!/bin/bash

# Get the arguments
label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

# Get the start time
start_time=$SECONDS

# Loop num_reps times
for ((i=1; i<=num_reps; i++)); do
    # Execute the query using DuckDB
    duckdb $db_file -c "$query" > /dev/null 2>&1
done

# Get the end time
end_time=$SECONDS

# Compute the elapsed time
elapsed=$((end_time - start_time))

# Divide the elapsed time by num_reps to get the average time per query
avg_time=$(echo "scale=7; $elapsed / $num_reps" | bc)

# Write the output to the CSV file
echo "$label,$avg_time" >> $csv_file