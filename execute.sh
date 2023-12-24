#!/bin/bash

ising_code=$1
input_values_file=$2

output_binning=output_binning_$1_$2.out
output_plotting=output_plotting_$1_$2.out

# COMPILE ISING CODE
gfortran $ising_code r1279.f90 ran2.f -o ising.out

# COMPILE BINNING CODE
gfortran binning.F90 -o binning.out

# COMPILE PLOTTING CODE
gfortran plotting.F90 -o plotting.out

#cat $input_values_file $spins_file > tmp_input.dat
cat $input_values_file > tmp_input.dat


#./ising.out < tmp_input.dat | tee >(./binning.out > $output_binning) | ./plotting.out > $output_plotting
./ising.out < tmp_input.dat | tee >(./binning.out > $output_binning) | ./plotting.out
#./ising.out < tmp_input.dat | ./binning.out 
#./ising.out < tmp_input.dat 
#./ising.out < tmp_input.dat | tee >(./binning.out > $output_binning)


echo > gnuplot.in 

echo "set xlabel \"m\"" >> gnuplot.in
echo "set ylabel \"Variance_energy\"" >> gnuplot.in
echo "set term png" >> gnuplot.in
echo "set output \"${output_binning}_energy.png\"" >> gnuplot.in
echo "plot \"${output_binning}\" using 1:4 with errorbars title \"$test_list\"" >> gnuplot.in

gnuplot gnuplot.in


echo > gnuplot.in 

echo "set xlabel \"m\"" >> gnuplot.in
echo "set ylabel \"Variance_magne\"" >> gnuplot.in
echo "set term png" >> gnuplot.in
echo "set output \"${output_binning}_magne.png\"" >> gnuplot.in
echo "plot \"${output_binning}\" using 1:6 with errorbars title \"$test_list\"" >> gnuplot.in

gnuplot gnuplot.in


echo > gnuplot.in 

echo "set xlabel \"t\"" >> gnuplot.in
echo "set ylabel \"E\"" >> gnuplot.in
echo "set term png" >> gnuplot.in
echo "set output \"${output_plotting}_energy.png\"" >> gnuplot.in
echo "plot \"${output_plotting}\" using 1:2 with errorbars title \"$test_list\"" >> gnuplot.in

gnuplot gnuplot.in

echo > gnuplot.in 

echo "set xlabel \"t\"" >> gnuplot.in
echo "set ylabel \"M\"" >> gnuplot.in
echo "set term png" >> gnuplot.in
echo "set output \"${output_plotting}_magne.png\"" >> gnuplot.in
echo "plot \"${output_plotting}\" using 1:3 with errorbars title \"$test_list\"" >> gnuplot.in

gnuplot gnuplot.in

#rm tmp_input.dat

