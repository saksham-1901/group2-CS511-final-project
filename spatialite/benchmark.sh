#!/bin/bash

# Check for at least one argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <SQL_FILE>"
    exit 1
fi

# Variables
DB_PATH="databases/urbana-network.sqlite"
SQL_FILE="$1"
TIMES_TO_RUN=100
TOTAL_TIME_MS=0
SESSION_NAME="SpatialiteSession_$(date +%s%N)" # Unique session name based on nanosecond timestamp

# Check for gdate and screen availability
if ! command -v gdate &>/dev/null || ! command -v screen &>/dev/null; then
    echo "gdate or screen could not be found. Please install coreutils and screen."
    exit 1
fi

# Start spatialite in a uniquely named detached screen session
screen -dmS $SESSION_NAME spatialite $DB_PATH

# Wait a bit to ensure spatialite is ready
sleep 2

# Run the benchmark loop
for ((i = 1; i <= TIMES_TO_RUN; i++)); do
    START_TIME=$(gdate +%s%N)

    # Execute the SQL commands by sending them to the screen session
    screen -S $SESSION_NAME -p 0 -X stuff "$(cat $SQL_FILE)$(echo -ne '\015')"

    END_TIME=$(gdate +%s%N)
    RUN_TIME=$((END_TIME - START_TIME))
    RUN_TIME_MS=$((RUN_TIME / 1000000))
    TOTAL_TIME_MS=$((TOTAL_TIME_MS + RUN_TIME_MS))
    echo "Run $i: $RUN_TIME_MS ms"
done

# Clean up: send quit command to screen session and then kill it
screen -S $SESSION_NAME -p 0 -X stuff ".quit$(echo -ne '\015')"
sleep 1 # give time for the command to execute
screen -S $SESSION_NAME -X quit

# Calculate and output average execution time
AVG_TIME_MS=$((TOTAL_TIME_MS / TIMES_TO_RUN))
echo "Average execution time: $AVG_TIME_MS ms"
