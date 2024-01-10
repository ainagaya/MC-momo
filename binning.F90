Program binning
	Implicit none
	integer :: N_MC_steps, nmeas, skip, Nvalues, L, z
	integer :: m, counter, i,  number_of_bins, k, k_max, t, j
	real(8), dimension(:), allocatable :: av_bin_ene, av_bin_magne
	real(8) :: sum_s_ene, sum_bin_j_ene, sum_s_magne, sum_bin_j_magne, Temp
	real(8), dimension(:), allocatable :: energy, magne
	real(8) :: mean_ene, s_2_ene, mean_magne, s_2_magne, skip_me

	character(len=90) :: filename, strL, strT, strNMCsteps, strm

	! Read the input from stdrd input
	read(5, *) L
	read(5, *) z
	read(5, *) Temp
	read(5, *) N_MC_steps
	read(5, *) nmeas

	! Convert real to string
  	write(strL, '(I3)') L
    write(strT, '(F3.1)') Temp
    write(strNMCsteps, '(I1)') N_MC_steps

    read(5,*) N_MC_steps, nmeas, skip

	Nvalues =  (N_MC_steps)/nmeas
	skip = skip/nmeas

	Nvalues = Nvalues - skip


	print*, "#--------------- BINNING STARTS --------------------"
	print*, N_MC_steps, Nvalues

	allocate(energy(Nvalues)) 
	allocate(magne(Nvalues))

	print*, "#m	", "number_of_bins	", "mean_ene	", "s_2_ene	", "mean_magne	", "s_2_magne	"

	do i = 1, skip
		read(5,*) skip_me, skip_me
	end do

	do i = 1, Nvalues
		read(5,*) energy(i), magne(i)
		write(50,*) i
	end do

	k_max = 1

	!do while (Nvalues/(100*k_max).gt.100)
	do while ((Nvalues/(2**k_max)).gt.100)
		k_max = k_max + 1
	end do

	print*, k_max

	do k = 0, k_max - 1 !Iterates for all m's
		m = 2**k
		write(strm, '(I5)') m

		filename=trim("Binning_L" // adjustl(trim(strL)) // "_T" // adjustl(trim(strT)) // "_NMCsteps" // adjustl(trim(strNMCsteps)) &
				// "_m" // adjustr(trim(adjustl(trim(strm)))) // ".dat")

		OPEN(15, FILE=filename)
	!do k = 1, k_max  !Iterates for all m's
	!	m = 100*k	
		number_of_bins = Nvalues/m
		sum_s_ene = 0.d0
		sum_s_magne = 0.d0

		allocate(av_bin_ene(number_of_bins))
		allocate(av_bin_magne(number_of_bins))

		do j = 1, number_of_bins 
			sum_bin_j_ene = 0.d0
			sum_bin_j_magne = 0.d0

			do t = (j-1)*m + 1, j*m
				sum_bin_j_ene = sum_bin_j_ene + energy(t)
				sum_bin_j_magne = sum_bin_j_magne + magne(t)
			end do

			av_bin_ene(j) = sum_bin_j_ene/m
			av_bin_magne(j) = sum_bin_j_magne/m
		
			write(15,*) av_bin_ene(j), av_bin_magne(j)
		end do

		close(15)

		mean_ene = (sum(av_bin_ene))/number_of_bins
		mean_magne = (sum(av_bin_magne))/number_of_bins


		do j = 1, number_of_bins
			sum_s_ene = sum_s_ene + (av_bin_ene(j) - mean_ene)**2
			!print*, sum_s_magne
			sum_s_magne = sum_s_magne + (av_bin_magne(j) - mean_magne)**2
		end do	

		s_2_ene = 1.d0/(number_of_bins*(number_of_bins-1.d0))*sum_s_ene
		s_2_magne = 1.d0/(number_of_bins*(number_of_bins-1.d0))*sum_s_magne

		print*, m, number_of_bins, mean_ene, s_2_ene, s_2_ene**(1./2.), mean_magne, s_2_magne, s_2_magne**(1./2.)

		deallocate(av_bin_ene)
		deallocate(av_bin_magne)

	end do


	deallocate(energy)
	deallocate(magne)

end program

