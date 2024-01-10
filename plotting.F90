Program binning
	Implicit none
	integer :: N_MC_steps, nmeas, skip, Nvalues
	integer :: i
	real(8)	:: energy, magne

	read(5,*) N_MC_steps, nmeas, skip

	Nvalues =  (N_MC_steps)/nmeas
	skip = skip/nmeas

	Nvalues = Nvalues - skip

	print*, "#--------------- PLOTTING --------------------"
	print*, Nvalues


	print*, "t", "ene	", "magne	"

	do i = 1, Nvalues
		!print*,i
		read(5, *) energy, magne
		if (mod(i, 100).eq.0) then
			print*, 100*i*nmeas, energy, magne
		end if
	end do


end program

