Program binning
	Implicit none
	integer, parameter :: N_MC_steps = 100000000
	integer :: m, counter, i,  number_of_bins
	real(8), dimension(:), allocatable :: m_k, m_k_2
	real(8) :: sum_1, sum_2, energy
	real(8) :: mean, strd

	number_of_bins = int(N_MC_steps/m)

	allocate(m_k(number_of_bins))
	allocate(m_k_2(number_of_bins))

	m = 1

	sum_1 = 0
	sum_2  = 0

	counter = 0
	
	do i = 1, N_MC_steps
		
		read(5, *) energy
		sum_1 = sum_1 + energy
		sum_2 = sum_2 + energy*energy 

		if (mod(i, m).eq.0) then
			counter = counter + 1
			m_k(counter) = sum_1
			m_k_2(counter) = sum_2

			sum_1 = 0
			sum_2 = 0

		end if 
	
	end do



	mean = sum(m_k) / (N_MC_steps/m)

	strd = (1.d0/(N_MC_steps/m) * (sum(m_k_2) - sum(m_k)**2)) ** (1./2.) 

	print*, mean, strd

	deallocate(m_k)
	deallocate(m_k_2)


end program

