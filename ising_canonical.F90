
Program Ising_canonical
	Implicit none
	integer :: L, z
	integer :: i, x, y, k
	integer, dimension(:), allocatable :: s
	integer, dimension(:, :), allocatable :: nbr
	integer, dimension(:, :), allocatable :: in
	integer:: E, M
	character :: str


	! Read the input from stdrd input
	read(5, *) str, L
	read(5, *) str, z

	print*, "L: ", L, "z: ", z

	! Initialization of the connectivity array
	allocate(s(L*L))
	allocate(nbr(L*L, z))
	allocate(in(0:1, L*L))

	! Building the spin array
	do i = 1, L*L
		read(5, *) k, s(i)
		if (k.ne.i) then
			print*, "disordered file?"
		end if 
	end do

	! Array to apply PBC
	do i = 1, L
		in(0,i)=i-1
		in(1,i)=i+1
	end do
	
	in(0,1)=L
	in(1,L)=1

	! Build the neighouhood arrays
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

	call energy(s, nbr, L, z, E)
	call magnetization(s, L, M)

	print*, "Energy: ", E
	print*, "magnetization: ", M

	deallocate(s)
	deallocate(nbr)
	deallocate(in)

End program


Subroutine energy(s, nbr, L, z, E)
	Implicit none
	integer, intent(in) :: L, z
	integer, dimension(L*L), intent(in) :: s
	integer, dimension(L*L, z), intent(in) :: nbr
	integer :: i, k
	integer, intent(out) :: E

	E = 0
	do i = 1, L*L
		do k = 1, z
			E = E -0.5 * s(i)*s(nbr(i,k))
		end do
	end do


End Subroutine


Subroutine magnetization(s, L, M)
	Implicit none
	integer :: L, i
	integer, dimension(L*L), intent(in) :: s
	integer, intent(out) :: M

	M = 0
	do i = 1, L*L
		M = M + s(i)
	end do

End Subroutine