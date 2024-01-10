#!/bin/bash

# Loop through files with the specified pattern
for file in ./Jackknife_L100_T*_NMCsteps8.dat; do
    # Extract T value from the filename
    t_value=$(echo "$file" | grep -oP "T\d+\.\d+")

    # Create the destination file path
    destination_file="./Jackknife_results.dat"

    # Add T value in the first column and extract the 8th row from the source file, then append it to the destination file
    awk -v t="$t_value" 'NR==8 {print t,$0}' "$file" >> "$destination_file"

    echo "Processed $file, added T value and extracted row 8, and appended to $destination_file"
done

