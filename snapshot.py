import numpy as np
import matplotlib.pyplot as plt

# Assuming your file is named 'data.txt'
file_path = 'snapshot3.dat'

# Read the data from the file
matrix_data = np.loadtxt(file_path)

# Plot the matrix using imshow with custom colors for -1 and 1
plt.imshow(matrix_data, cmap='binary', vmin=-1, vmax=1)

# Add a colorbar to show the scale
plt.colorbar(ticks=[-1, 0, 1])

plt.title('T=3.0')

# Show the plot
plt.show()

