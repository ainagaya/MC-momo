import pandas as pd
import matplotlib.pyplot as plt

# Read data from the file
file_path = 'Jackknife_L100_T2.27_NMCsteps8.dat'  
data = pd.read_table(file_path, delim_whitespace=True)

# Extract relevant columns
m_values = data['m']
chi_values = data['magnetic_sus']
chi_errors = data['magnetic_sus_error']
c_values = data['heat_cap']
c_errors = data['heat_cap_error']

# Plotting χ and its jackknife error
plt.figure(figsize=(12, 6))

plt.subplot(1, 2, 1)
plt.plot(m_values, chi_errors)
plt.xlabel('m')
plt.ylabel('Magnetic susceptibility Jackknife error')
plt.title('Jackknife Error vs m, T=2.27')
plt.legend()

# Plotting c and its jackknife error
plt.subplot(1, 2, 2)
plt.plot(m_values, c_errors)
plt.xlabel('m')
plt.ylabel('Heat capacity Jackknife error')
plt.title('Jackknife Error vs m, T=2.27')
plt.legend()

plt.tight_layout()
plt.show()

