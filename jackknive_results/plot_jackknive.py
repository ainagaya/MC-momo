import matplotlib.pyplot as plt
import numpy as np

# Load data from the file
data = np.loadtxt("Jackknife_results.dat", dtype=float)

# Extract errors from the file
x_errors = data[:,3]
c_errors = data[:,5]

# Plot X as a function of T with error bars
plt.figure(1)
plt.errorbar(data[:,0], data[:,2], yerr=x_errors, fmt='o', capsize=5)
plt.xlabel('Temperature (T)')
plt.ylabel('X')
plt.title('Magnetic susceptibility, L=100')
plt.grid(True)

# Plot C as a function of T with error bars
plt.figure(2)
plt.errorbar(data[:,0], data[:,4], yerr=c_errors, fmt='o', capsize=5)
plt.xlabel('Temperature (T)')
plt.ylabel('C')
plt.title('Heat Capacity, L=100')
plt.grid(True)

# Show the plots
plt.show()

