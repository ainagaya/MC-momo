#!/bin/bash

executable=$1
input_values_file=$2
spins_file=$3
binning=$4
output=output_$1_$2_$3.out

cat $input_values_file $spins_file > tmp_input.dat

#./$executable < tmp_input.dat | ./$binning 
./$executable < tmp_input.dat 


#rm tmp_input.dat

