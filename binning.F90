Program binning
	Implicit none
	integer :: N_MC_steps, nmeas, skip, Nvalues
	integer :: m, counter, i,  number_of_bins, k, k_max, t, j
	real(16), dimension(:), allocatable :: av_bin_ene, av_bin_magne
	real(16) :: sum_s_ene, sum_bin_j_ene, sum_s_magne, sum_bin_j_magne
	real(16), dimension(:), allocatable :: energy, magne
	real(16) :: mean_ene, s_2_ene, mean_magne, s_2_magne

	read(5, *) N_MC_steps, nmeas, skip

	Nvalues =  (N_MC_steps)/nmeas

	print*, "#--------------- BINNING STARTS --------------------"
	print*, Nvalues

	allocate(energy(Nvalues)) 
	allocate(magne(Nvalues))

	print*, "#m	", "number_of_bins	", "mean_ene	", "s_2_ene	", "mean_magne	", "s_2_magne	"

	do i = skip, Nvalues
		read(5, *) energy(i), magne(i)
	end do

	k_max = 1

	do while (Nvalues/(100*k_max).gt.100)
		k_max = k_max + 1
	end do

	print*, k_max

	!do k = 0, k_max - 1 !Iterates for all m's
	!	m = 2**k
	do k = 1, k_max  !Iterates for all m's
		m = 100*k	
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
		
		end do


		mean_ene = (sum(av_bin_ene))/number_of_bins
		mean_magne = (sum(av_bin_magne))/number_of_bins


		do j = 1, number_of_bins
			sum_s_ene = sum_s_ene + (av_bin_ene(j) - mean_ene)**2
			!print*, sum_s_magne
			sum_s_magne = sum_s_magne + (av_bin_magne(j) - mean_magne)**2
		end do	

		s_2_ene = 1.d0/(number_of_bins*(number_of_bins-1.d0))*sum_s_ene
		s_2_magne = 1.d0/(number_of_bins*(number_of_bins-1.d0))*sum_s_magne


		print*, m, number_of_bins, mean_ene, s_2_ene, mean_magne, s_2_magne

		deallocate(av_bin_ene)
		deallocate(av_bin_magne)

	end do


	deallocate(energy)
	deallocate(magne)

end program

