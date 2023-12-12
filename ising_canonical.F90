
Program Ising_canonical
	Implicit none
	integer :: L, z, n, step, N_MC_steps
	integer :: i, x, y, k, iseed
	real(8), dimension(:), allocatable :: s, table
	integer, dimension(:, :), allocatable :: nbr
	real(8), dimension(:, :), allocatable :: in
	real(8):: E, M, beta, T
	real :: r1279
	character :: str


	T = 2.d0
	beta = 1.d0/T
	N_MC_steps = 1

	! Read the input from stdrd input
	read(5, *) str, L
	read(5, *) str, z
	read(5, *) str, iseed

	call setr1279(iseed)

	print*, iseed

	print*, r1279()

	print*, "L: ", L, "z: ", z

	! Initialization of the connectivity array
	allocate(s(L*L))
	allocate(nbr(L*L, z))
	allocate(in(0:1, L*L))
	allocate(table(-z:z))

	open(33, file="test_configuration.dat", status = "old")

	! Building the spin array
	do i = 1, L*L
		read(33, *) k, s(i)
		if (k.ne.i) then
			print*, "disordered file?"
		end if 
	end do

	do i = -z, z
		n = 2*i
		table(i) = exp(-beta*n)
		print*, table(i)
	end do

	! Array to apply initial conditions
	do i = 1, L
		in(0,i)=i-1
		in(1,i)=i+1
	end do
	
	in(0,1)=L
	in(1,L)=1

	! Build the neighouhood array
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

	do step = 1, N_MC_steps
		call MC_move(s, L, E, z, nbr)
		print*, E
	end do

	deallocate(s)
	deallocate(nbr)
	deallocate(in)

End program


Subroutine energy(s, nbr, L, z, E)
	Implicit none
	integer, intent(in) :: L, z
	real(8), dimension(L*L), intent(in) :: s
	integer, dimension(L*L, z), intent(in) :: nbr
	integer :: i, k
	real(8), intent(out) :: E

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
	real(8), dimension(L*L), intent(in) :: s
	real(8), intent(out) :: M

	M = 0
	do i = 1, L*L
		M = M + s(i)
	end do

End Subroutine


Subroutine MC_move(s, L, E, z, nbr)
	Implicit none
	integer, intent(in) :: L, z
	real(8), dimension(L*L) :: s, s_new
	integer :: i, flip, delta_E, N
	real(8) :: E, energy_new, exp, rnd
	real :: r1279
	integer, dimension(N, z) :: nbr
	real(8), dimension(-z:z) :: table

	N = L*L

	do flip = 1, N
		s_new = s
		i=mod(int(N*r1279()),N)+1
		s_new(i)=s_new(i)*(-1)
		call energy(s_new, nbr, L, z, energy_new)

		delta_E = int(energy_new - E)
		!print*, delta_E 
		print*, delta_E

		if (delta_E.lt.0) then
			!print*, "change accepted"
			s = s_new
			E = energy_new

		else if (delta_E.ge.0) then
			rnd = r1279()
			exp = table(int(delta_E/2.d0))
			if (rnd.lt.exp) then
				print*, "change accepted"
				s = s_new
				E = energy_new
			end if				

		end if
		
	end do




End Subroutine

