#!/bin/bash

executable="./cobra"
test_dir="$(pwd)/tests"

for file in "$test_dir"/*; do
    if [ -f "$file" ]; then
        echo "Running $executable against $(basename "$file")"
        if ! "$executable" < "$file"; then
            exit 1
        fi
    fi
done
