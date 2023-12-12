
Program Ising_canonical
	Implicit none
	integer, parameter :: L=10, Numsteps=100
	integer :: step
	real(8), dimension(:), allocatable :: s



	allocate(s(L*L))

	do i = 1, L*L
		s(i) = 2*mod(int(2*r1279(),2) - 1
	end do


	do step = 1, Numsteps
		i=mod(int(N*r1279()),N)+1
	end do

	deallocate(s)

End program
