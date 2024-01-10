#!/bin/bash

ising_code=${1:-"ising_canonical.F90"}


# COMPILE ISING CODE
gfortran $ising_code r1279.f90 ran2.f -o ising.out

# COMPILE BINNING CODE
gfortran binning.F90 -o binning.out

# COMPILE PLOTTING CODE
gfortran plotting.F90 -o plotting.out

# COMPILE JACKKNIVE CODE
gfortran jackknife.f90 -o jackknife.out

L=${2:-"100"}
z=4
T=${3:-"3.0"}
N_MC_steps=${4:-"8"}
nmeas=10

input_values_file="INPUTS_L${L}_T${T}_NMCsteps_${N_MC_steps}.in"

echo $L > $input_values_file
echo $z >> $input_values_file
echo $T >> $input_values_file
echo $N_MC_steps >> $input_values_file
echo $nmeas >> $input_values_file

output_binning="output_binning_L${L}_T${T}_NMCsteps${N_MC_steps}"
output_plotting="output_plotting_L${L}_T${T}_NMCsteps${N_MC_steps}"

./ising.out < $input_values_file

ising_result="Ising_canonical_L${L}_T${T}_NMCsteps${N_MC_steps}.dat"	

cat "$input_values_file" "$ising_result" > input.binning

./binning.out < input.binning > "${output_binning}.out"

#./plotting.out < $ising_result > ${output_plotting}.out

for m in 1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192; do

	output_binning="Binning_L${L}_T${T}_NMCsteps${N_MC_steps}_m${m}.dat"

	cat "$input_values_file" > input.jack
	echo $m >> input.jack
	cat "$output_binning" >> input.jack

	./jackknife.out < input.jack

done

echo "adjusting energy"

echo > gnuplot.in 

echo "set xlabel \"m\"" >> gnuplot.in
echo "set ylabel \"Variance_{energy}\"" >> gnuplot.in
echo "set term eps" >> gnuplot.in
echo "set output \"${output_binning}_energy.eps\"" >> gnuplot.in
echo "f(x) = a - b*exp(-x/t)" >> gnuplot.in
echo "fit f(x) \"${output_binning}.out\" using 1:4 via a, b, t" >> gnuplot.in
echo "plot \"${output_binning}.out\" using 1:4 with errorbars title \"$test_list\", f(x) with lines title sprintf('Fit (t=%.2f)', t)" >> gnuplot.in

gnuplot gnuplot.in

echo "adjusting magne"

echo > gnuplot.in 

echo "set xlabel \"m\"" >> gnuplot.in
echo "set ylabel \"Variance_{magne}\"" >> gnuplot.in
echo "set term eps" >> gnuplot.in
echo "set output \"${output_binning}_magne.eps\"" >> gnuplot.in
echo "f(x) = a - b*exp(-x/t)" >> gnuplot.in
echo "fit f(x) \"${output_binning}.out\" using 1:7 every via a, b, t" >> gnuplot.in
echo "plot \"${output_binning}.out\" using 1:7 every with errorbars title \"$test_list\",  f(x) with lines title sprintf('Fit (t=%.2f)', t)" >> gnuplot.in

gnuplot gnuplot.in

echo "plotting energy"

echo > gnuplot.in 

echo "set xlabel \"t\"" >> gnuplot.in
echo "set ylabel \"E\"" >> gnuplot.in
echo "set term eps" >> gnuplot.in
echo "set output \"${output_plotting}_energy.eps\"" >> gnuplot.in
echo "plot \"${output_plotting}.out\" using 1:2 with errorbars title \"$test_list\"" >> gnuplot.in

gnuplot gnuplot.in

echo "plotting magne"

echo > gnuplot.in 

echo "set xlabel \"t\"" >> gnuplot.in
echo "set ylabel \"M\"" >> gnuplot.in
echo "set term png" >> gnuplot.in
echo "f(x)"
echo "set output \"${output_plotting}_magne.eps\"" >> gnuplot.in
echo "plot \"${output_plotting}.out\" using 1:3 with errorbars title \"$test_list\"" >> gnuplot.in

gnuplot gnuplot.in

#rm tmp_input.dat

