Program binning
	Implicit none
	integer :: N_MC_steps, nmeas
	integer :: m, counter, i,  number_of_bins, k, k_max
	real(8), dimension(:), allocatable :: m_k, m_k_2
	real(8) :: sum_1, sum_2
	real(8), dimension(:), allocatable :: energy
	real(8) :: mean, strd

	read(5, *) N_MC_steps

	print*, "hola"

	allocate(energy(N_MC_steps))

	do i = 1, N_MC_steps/nmeas
		read(5, *) energy(i)
		print*, i
	end do

	k_max = 1

	do while (N_MC_steps/(2**k_max).gt.100)
		k_max = k_max + 1
	end do

	k_max = k_max - 1

	do k = 1, k_max
		m = 2**k
		number_of_bins = N_MC_steps/m

		allocate(m_k(number_of_bins))
		allocate(m_k_2(number_of_bins))
		print*, number_of_bins
		
		sum_1 = 0
		sum_2  = 0

		counter = 0
		do i = 1, N_MC_steps
			sum_1 = sum_1 + energy(i)
			sum_2 = sum_2 + energy(i)*energy(i) 

			if (mod(i, m).eq.0) then
				counter = counter + 1
				m_k(counter) = sum_1/m
				m_k_2(counter) = sum_2/m

				sum_1 = 0
				sum_2 = 0

			end if 
		
		end do
		
		mean = sum(m_k) / number_of_bins

		strd = ((1.d0/number_of_bins*(sum(m_k_2))) - mean**2) ** (1./2.) 

		print*, m, mean, strd

		deallocate(m_k)
		deallocate(m_k_2)
	end do


	deallocate(energy)

end program

