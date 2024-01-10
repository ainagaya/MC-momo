PROGRAM CalculateStatistics
    implicit none
    
    INTEGER :: N ! Number of data points
    REAL(8), dimension(:), allocatable :: X, Y, X2, Y2 ! Array to store the data
    REAL(8), dimension(:), allocatable :: XJ, YJ, X2J, Y2J ! Array to store the jackknife bins
    REAL(8) :: f_i_J_x2, f_i_J_x_2, DifferenceX, f_i_J_y2, f_i_J_y_2, DifferenceY, T
    REAL(8) :: FMX, FVX, FEX, FMY, FVY, FEY ! Jackknife estimators
    real(8) :: beta, magnetic_sus, magnetic_sus_error, heat_cap, heat_cap_error 
    
    character(len=80) :: filename, strL, strT, strNMCsteps, strm
    integer :: L, z, step, N_MC_steps, nmeas, i, m, status

    ! Read the input from stdrd input
	read(5, *) L
	read(5, *) z
	read(5, *) T
	read(5, *) N_MC_steps
	read(5, *) nmeas
    read(5, *) m

	! Convert real to string
  	write(strL, '(I3)') L
    write(strm, '(I5)') m
    write(strT, '(F3.1)') T
    write(strNMCsteps, '(I1)') N_MC_steps

    N_MC_steps = 10**(N_MC_steps)
    N = (N_MC_steps - 1000) / nmeas
    N = n/m
    beta = 1/T

    print*, N

    allocate(X(N), XJ(N), X2(N), X2J(N), Y(N), YJ(N), Y2(N), Y2J(N))

    ! Read data from input file

    DO I = 1, N
        READ(5, *) X(I), Y(I)
        X2(I)=X(I)*X(I)
        Y2(I)=Y(I)*Y(I)
    END DO

    print*, sum(X)/N, sum(Y)/N
    
    ! Calculate jackknife bins

    CALL DATJACK(N, X, XJ)
    CALL DATJACK(N, X2, X2J)

    CALL DATJACK(N, Y, YJ)
    CALL DATJACK(N, Y2, Y2J)

    
    ! Calculate <X^2>
    f_i_J_x2 = sum(X2J)/N
    f_i_J_y2 = sum(Y2J)/N
    
    ! Calculate <X>^2
    f_i_J_x_2 = (sum(XJ)/N)**2
    f_i_J_y_2 = (sum(YJ)/N)**2

    
    ! Calculate the difference
    DifferenceX = f_i_J_x2 - f_i_J_x_2
    DifferenceY = f_i_J_y2 - f_i_J_y_2
    
    ! Calculate jackknife estimators
    CALL STEBJ0(N, XJ, FMX, FVX, FEX)

    CALL STEBJ0(N, YJ, FMY, FVY, FEY)
    
    ! Print the results
    WRITE(*,*) "<X^2> =", f_i_J_x2
    WRITE(*,*) "<X>^2 =", f_i_J_x_2
    WRITE(*,*) "Difference X =", DifferenceX
    WRITE(*,*) "Jackknife Mean X =", FMX
    WRITE(*,*) "Jackknife Variance X =", FVX
    WRITE(*,*) "Jackknife Error Bar X =", FEX

    WRITE(*,*) "<Y^2> =", f_i_J_y2
    WRITE(*,*) "<Y>^2 =", f_i_J_y_2
    WRITE(*,*) "Difference Y =", DifferenceY
    WRITE(*,*) "Jackknife Mean Y =", FMY
    WRITE(*,*) "Jackknife Variance Y =", FVY
    WRITE(*,*) "Jackknife Error Bar Y =", FEY

    magnetic_sus=beta*L*L*DifferenceY !multiplying by N=L*L because our variables are per spin already
    heat_cap=beta**2*L*L*DifferenceX
    
    magnetic_sus_error=beta*L*L*FEY
    heat_cap_error=beta*L*L*FEX

    filename=trim("Jackknife_L"//adjustl(trim(strL))//"_T"//adjustl(trim(strT))//"_NMCsteps"//adjustl(trim(strNMCsteps))//".dat")
    open(12, file=filename, status='unknown', action='write', position='append', iostat=status)
    WRITE(12,*) m, magnetic_sus, magnetic_sus_error, heat_cap, heat_cap_error
    close(12)

    deallocate(X, XJ, X2, X2J, Y, YJ, Y2, Y2J)

CONTAINS



    FUNCTION CalculateMean(Data, N) RESULT(Mean)
        REAL(8), DIMENSION(:), INTENT(IN) :: Data
        INTEGER, INTENT(IN) :: N
        REAL :: Mean
        INTEGER :: I
        Mean = 0.0
        DO I = 1, N
            Mean = Mean + Data(I)
        END DO
        Mean = Mean / REAL(N)
    END FUNCTION CalculateMean

END PROGRAM CalculateStatistics


      SUBROUTINE DATJACK(N,X,XJ)
!Copyright, Bernd Berg, Dec13 2000.
! CALCULATION OF  N  JACKKNIFE BINS  XJ(N)  FOR  N  DATA IN  X(N).        
      include 'implicit.sta'
      include 'constants.par'
      DIMENSION X(N),XJ(N)
      XSUM=ZERO
      DO I=1,N
        XSUM=XSUM+X(I)
      END DO
      FACTOR=ONE/(N-1)
      DO I=1,N
        XJ(I)=FACTOR*(XSUM-X(I))
      END DO
      RETURN
      END


      SUBROUTINE STEBJ0(N,FJ,FM,FV,FE)
!                                                                     
! CALCULATION OF JACKKNIFE ESTIMATORS FROM  N  JACKKNIFE BINS  FJ(N):
!                                                                     
! - THE MEAN VALUE:   FM,
! - THE VARIANCE:     FV,
! - THE ERROR BAR:    FE=SQRT(FV/N), (STANDARD DEVIATION OF FM).   
!                                                                     
      include 'implicit.sta' 
      include 'constants.par' 
      DIMENSION FJ(N)
!
      IF(N.LT.2) STOP 'STEBJ0: N TOO SMALL!'
      FM=ZERO
      FV=ZERO
!
      DO I=1,N
        FM=FM+FJ(I)
      END DO
      FM=FM/N
! 
      DO I=1,N
        FV=FV+(FJ(I)-FM)**2
      END DO
      FV=FV*(N-1)
      FE=SQRT(FV/(N*ONE))
      RETURN
      END
