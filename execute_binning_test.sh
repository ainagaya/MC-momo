#!/bin/bash

test_list=$1
output=binning_test_$1.out


# COMPILE BINNING CODE
gfortran binning.F90 -o binning.out

# Get the number of lines in $test_list
num_lines=$(wc -l < "$test_list")

# Write the number of lines to nlines.dat
echo "$num_lines 1 0" > nlines.dat

# Concatenate tmp_input.dat and $test_list and save it to tmp_input
cat nlines.dat "$test_list" > tmp_input


./binning.out < tmp_input > $output
#./$executable < tmp_input.dat 

echo > gnuplot.in 

echo "set xlabel \"m\"" >> gnuplot.in
echo "set ylabel \"Variance\"" >> gnuplot.in
echo "set term png" >> gnuplot.in
echo "set output \"${output}.png\"" >> gnuplot.in
echo "plot \"${output}\" using 1:4 with errorbars title \"$test_list\"" >> gnuplot.in

gnuplot gnuplot.in


#rm tmp_input.dat

