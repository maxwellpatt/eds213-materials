#!/bin/bash

# Check if all required arguments are provided
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 label num_reps query db_file csv_file"
    exit 1
fi

# Assign the arguments 
label="$1"    # Explanatory label that will be output
num_reps="$2" # Number of repetitions
query="$3"    # SQL query to run
db_file="$4"  # Database file
csv_file="$5" # CSV file to create or append to

# Get and store start time
start_time=$SECONDS

# Loop num_reps times, hiding output
for ((i=0; i<num_reps; i++)); do
    # Generate a small random delay between 0 and 0.01 seconds
    delay=$(awk "BEGIN {printf \"%.2f\", rand() / 100}")
    sleep "$delay"
    
    duckdb "$db_file" -c "$query" >/dev/null 2>&1
done

# Get end time
end_time=$SECONDS

# Calculate elapsed time and avg time per query
elapsed_time=$((end_time - start_time))
rep_time=$(awk "BEGIN {printf \"%.20f\", $elapsed_time / $num_reps}")

# Create output csv
echo "$label,$rep_time" >> "$csv_file"





# To determine which of the three methods for finding species without nest data is the fastest, 
# I used the provided test harness script to time three different queries: an outer join, EXCEPT, and NOT IN. 
# Each query was run for 1000 repetitions to get reliable average timings. The results tell us that the outer 
# join method is the fastest, with an average execution time of 0.047 seconds. The NOT IN method is a bit slower 
# at 0.051 seconds, and the EXCEPT method is the slowest with an average time of 0.053 seconds. The outer join 
# approach appears to be the most efficient way to identify species lacking nest data in the given dataset.
