
Program Ising_canonical
	Implicit none
	integer, parameter :: L=4, z=4
	integer :: i, x, y
	real(8), dimension(L*L) :: s
	integer, dimension(L*L, z) :: nbr
	real(8), dimension(0:1, L*L) :: in


	! Initialization of the connectivity array


	! We define in
	do i = 1, L
		in(0,i)=i-1
		in(1,i)=i+1
	end do
	
	in(0,1)=L
	in(1,L)=1

	i=0
	do y = 1, L
		do x = 1, L
			i=i+1
			nbr(i,1) = in(1,x) + L*(y-1) ! ‘‘right’’
			nbr(i,2) = in(0,x) + L*(y-1) ! ‘‘left’’
			nbr(i,3) = x + L*(in(1,y)-1) ! ‘‘up’’
			nbr(i,4) = x + L*(in(0,y)-1) ! ‘‘down’’
		end do
	end do

	do i = 1, L*L
		print*, "Neighbours of", i, ": ", nbr(i,:)
	end do

End program


!Subroutine energy(s, nbr)
!	Implicit none

!	E = 0



!End Subroutine


Subroutine magnetization(s, N, M)
	Implicit none
	integer :: N, i
	real(8), dimension(N), intent(in) :: s
	real(8), intent(out) :: M

	M = 0
	do i = 1, N
		M = M + s(i)
	end do

End Subroutine