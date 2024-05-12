#!/bin/bash

executable="./cobra"
test_dir="$(pwd)/tests"

for file in "$test_dir"/*; do
    if [ -f "$file" ]; then
        echo "Running $executable against $(basename "$file")"
        output=$("$executable" < "$file" 2>&1)
        exit_code=$?

        echo "Output: $output"

        # Check for 'error_' in output and successful exit code
        if [[ "$output" == *"error_"* ]] && [[ $exit_code -eq 0 ]]; then
            echo "Failure: Found 'error_' in output but exit code is 0."
            exit 1
        fi

        # Check for 'success_' in output and failed exit code
        if [[ "$output" == *"success_"* ]] && [[ $exit_code -ne 0 ]]; then
            echo "Failure: Found 'success_' in output but exit code is non-zero."
            exit 1
        fi
    fi
done
