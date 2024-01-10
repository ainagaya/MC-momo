# Equilibrium Monte Carlo simulation of the 2D Ising model

### First steps:
What we reccomend to compile and run Monte Carlo simulations with this code is to use the `execute.sh` script. One can execute it as `./execute.sh` or `bash execute.sh`. One can add the following parameters as flags: 

`$1: ising_code`, to use another Ising code.
`$2: L`, size of the system. Default is `L=100`.
`$3: T`, temperature of the system. Default is set to `T=3.0`.
`$4: N_MC_steps`, power of 10 of the number of Monte Carlo steps that will be performed. Default is set to 8, so the number of steps will be $10^8$.  


It will:
- Compile all the Fortran codes used to perform simulations.
- Create the inputs for your specified variables, that will be used as standard input for the ising code.
- Perform the simulation.
- When the simulation ends, perform the binning code with `binning.F90` code.
- Group data to produce some plots with the `plotting.F90` code.
- Execute the Jackknife code to produce Magnetization and Heat Capacity. 
- Make some plots for the user to check that the simulations are going well. Those are not the ones included in the final report.

### Recommended usage:
To perform the production runs over different values of `T`, one can use `execute_temp_loop.sh`, which iterates for different values of `T`. 
All the output produced by the ising code follows the pattern: `Ising_canonical_L$L_T$T_NMCsteps$N.dat`, so the data is never overwritten, and the files are easily accessible for the other codes used. 

### Additional information:
The seed used in the Ising code is `nmeas` in all the simulations.


### Contact information
- Aina Gaya Àvila, agayaavi53@alumnes.ub.edu
- Adria Barbecho, abarbeba132@alumnes.ub.edu
