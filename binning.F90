Program binning
	Implicit none
	integer :: m, counter, i, N_MC_steps
	real(8), dimension(int(N_MC_steps/m)) :: m_k, m_k_2
	real(8) :: sum, sum_2, energy


	m = 1

	sum = 0
	sum_2  = 0

	counter = 0
	
	do i = 1, N_MC_steps
		
		read(5, *) energy
		sum = sum + energy
		sum_2 = sum_2 + energy*energy 

		if (mod(i, m).eq.0) then
			counter = counter + 1
			m_k(counter) = sum
			m_k_2(counter) = sum_2

			sum = 0
			sum_2 = 0

		end if 
	
	end do



	mean = sum(m_k) / (N_MC_steps/m)

	strd = (1.d0/(N_MC_steps/m) * (sum(m_k_2) - sum(m_k)**2))**(1./2.) 




end program

