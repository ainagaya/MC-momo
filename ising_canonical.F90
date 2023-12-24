
Program Ising_canonical
	Implicit none
	integer :: L, z, n, step, N_MC_steps, nmeas, skip, T
	integer :: i, x, y, k, counter
	integer, dimension(:), allocatable :: s
	real(8), dimension(:), allocatable :: table
	integer, dimension(:, :), allocatable :: nbr, in
	real(8):: E, M, beta, mean
	real :: r1279
	character, dimension(3) :: str
	real :: start_MC, finish_MC

	skip = 1000

	! Read the input from stdrd input
	read(5, *) L
	read(5, *) z
	read(5, *) T
	read(5, *) N_MC_steps
	read(5, *) nmeas

	print*, N_MC_steps, nmeas, skip

	beta = 1.d0/T

	call setr1279(nmeas)

	! Initialization of the connectivity array
	allocate(s(L*L))
	allocate(nbr(L*L, z))
	allocate(in(0:1, L*L))
	allocate(table(-z:z))

	! Building the spin array
	do i = 1, L*L
		s(i) = 2*mod(int(2*r1279()),2) - 1
	end do

	! Array to apply PBC
	do i = -z, z
		n = 2*i
		table(i) = exp(-beta*n)
!		print*, table(i)
	end do

	! Array to apply initial conditions
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

	call energy(s, nbr, L, z, E)
	call magnetization(s, L, M)

	write(11,*) "Energy: ", E
!	print*, "magnetization: ", M

	call cpu_time(start_MC)

	mean = 0.d0
	counter = 0
	do step = 1, N_MC_steps
		call MC_move(s, L, E, M, z, nbr, table)
		! strd output
		if (mod(step, nmeas).eq.0) then
			print*, E/(L*L), M/(L*L) 
		end if
		
	!	call energy(s, nbr, L, z, energy_new)

!		if (energy_new.ne.E) then
!			write(11,*) step, energy_new, E
!		end if

	end do
	call cpu_time(finish_MC)

	write(10,*) "Mean (simple):", mean/counter


	write(10, *)  "Total time = ",finish_MC-start_MC," seconds. "
	write(10, *)  "Time_MC_update = ",(finish_MC-start_MC)/(N_MC_steps*L*L)," seconds."

	deallocate(s)
	deallocate(nbr)
	deallocate(in)

End program

! ---------------------------------------------------------------------

Subroutine energy(s, nbr, L, z, E)
	Implicit none
	integer, intent(in) :: L, z
	integer, dimension(L*L), intent(in) :: s
	integer, dimension(L*L, z), intent(in) :: nbr
	integer :: i, k
	real(8), intent(out) :: E

	E = 0
	do i = 1, L*L
		do k = 1, z
			E = E - 0.5 * s(i)*s(nbr(i,k))
		end do
	end do


End Subroutine


Subroutine magnetization(s, L, M)
	Implicit none
	integer :: L, i
	integer, dimension(L*L), intent(in) :: s
	real(8), intent(out) :: M

	M = 0
	do i = 1, L*L
		M = M + s(i)
	end do

End Subroutine


Subroutine MC_move(s, L, E, M, z, nbr, table)
	Implicit none
	integer, intent(in) :: L, z
	integer, dimension(L*L) :: s
	integer :: i, flip, delta_E, N, k, aux
	real(8) :: E, energy_new, exp, rnd, h, M
	real :: r1279
	integer, dimension(L*L, z) :: nbr
	real(8), dimension(-z:z) :: table

	N = L*L

	do flip = 1, N

		! We decide a random particle to flip
		i=mod(int(N*r1279()),N)+1
		
		h = 0
		do k = 1, z
			h = h + s(nbr(i,k))
		end do

	!	write(11,*) "h ", h 

		!call energy(s_new, nbr, L, z, energy_new)

		! We take into account that we flipped the spin i
		!delta_E = 2*s(i)*(-1)*h aixi no coincideix amb la calculada amb la subrutina
		delta_E = 2*s(i)*h !aixi si qeu coincideix
	!	write(11,*) "DEBUG3:	", E, delta_E


		if (delta_E.lt.0) then
			!print*, "change accepted"
			s(i) = s(i)*(-1)
			E = E + delta_E
			M = M + 2*s(i)

!			call energy(s, nbr, L, z, energy_new)

!			if (energy_new.ne.E) then
!				write(11,*) "DEBUG1:	", flip, energy_new, E
!			end if

		else if (delta_E.ge.0) then
			rnd = r1279()
			exp = table(int(delta_E/2.d0))
			!print*, "exp:", exp
			if (rnd.lt.exp) then
			!	print*, "change accepted"
				s(i) = s(i)*(-1)
				E = E + delta_E
				M = M + 2*s(i)
				
!				call energy(s, nbr, L, z, energy_new)

!				if (energy_new.ne.E) then
!					write(11,*) "DEBUG2:	", flip, energy_new, E
!				end if	

			end if		

		end if
		
	end do

End Subroutine

