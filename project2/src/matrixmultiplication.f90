PROGRAM matrixmultiplication
  IMPLICIT NONE

  ! Sparse and dense matrix representations
  double precision, allocatable :: rowA(:), colA(:), valA(:)
  double precision, allocatable :: rowB(:), colB(:), valB(:)
  double precision, allocatable :: rowR(:), colR(:), valR(:)
  double precision, allocatable :: denseA(:,:), denseB(:,:), denseC(:,:), finalC(:,:)

  ! Input files and variables for dimensions
  character(len=100) :: input_fileA, input_fileB
  integer :: nA, mA, totvalA, nB, mB, totvalB, totvalR, nC, mC, nmult
  real(8) :: isparse, fsparse, tsparse, idense, fdense, tdense, fillA, fillB, fillR, iblas, fblas, tblas
  double precision :: alpha, beta
  integer :: i_stat
  alpha = 1.0d0
  beta = 0.0d0

  ! Prompt user for input files
  write(*,*) 'Enter the filename for matrix A (e.g., MATRIX_125_2p.txt):'
  read(*, '(A)') input_fileA
  write(*,*) 'Enter the filename for matrix B (e.g., MATRIX_125_1p.txt):'
  read(*, '(A)') input_fileB

  ! Define and process matrix A
  call get_dimension(input_fileA, nA, mA, totvalA)
  call read_matrix(input_fileA, totvalA, rowA, colA, valA)
  call dense_matrix(nA, mA, rowA, colA, valA, totvalA, denseA)
  fillA = real(totvalA) / (real(nA) * real(mA))
  write(*,*) 'The filling degree of A is ', fillA

  ! Define and process matrix B
  call get_dimension(input_fileB, nB, mB, totvalB)
  call read_matrix(input_fileB, totvalB, rowB, colB, valB)
  call dense_matrix(nB, mB, rowB, colB, valB, totvalB, denseB)
  fillB = real(totvalB) / (real(nB) * real(mB))
  write(*,*) 'The filling degree of B is ', fillB

  ! Ensure matrices are compatible for multiplication
  if (mA /= nB) then
    write(*,*) 'Error: Matrix dimensions are incompatible for multiplication (mA=', mA, ', nB=', nB, ')'
    stop
  end if

  ! Sparse Matrix Multiplication
  call cpu_time(isparse)
  call multiply_sparse(rowA, colA, valA, totvalA, rowB, colB, valB, totvalB, rowR, colR, valR, totvalR, nmult)
  call cpu_time(fsparse)
  tsparse = fsparse - isparse
  fillR = real(totvalR) / (real(nA) * real(mB))
  write(*,*) 'Sparse multiplication results:'
  write(*,*) '  Filling degree of result: ', fillR
  write(*,*) '  Number of multiplications: ', nmult
  write(*,*) '  Time taken: ', tsparse, ' seconds'

  ! Dense Matrix Multiplication
  call cpu_time(idense)
  call multiply_dense(nA, mA, denseA, mB, denseB, nC, mC, denseC)
  call cpu_time(fdense)
  tdense = fdense - idense
  write(*,*) 'Dense multiplication time: ', tdense, ' seconds'

  ! BLAS DGEMM Multiplication
  allocate(finalC(nA, mB), stat=i_stat)
  if (i_stat /= 0) then
    write(*,*) 'Error: Memory allocation for finalC failed'
    stop
  end if
  call cpu_time(iblas)
  call DGEMM('N', 'N', nA, mB, mA, alpha, denseA, nA, denseB, nB, beta, finalC, nA)
  call cpu_time(fblas)
  tblas = fblas - iblas
  write(*,*) 'BLAS multiplication time: ', tblas, ' seconds'

  ! Deallocate all allocated arrays
  deallocate(rowA, colA, valA, denseA)
  deallocate(rowB, colB, valB, denseB)
  deallocate(rowR, colR, valR)
  deallocate(denseC, finalC)

  contains

  subroutine get_dimension(input_file, n, m, totval)
    character(len=100), intent(in) :: input_file
    integer, intent(out) :: n, m, totval
    character(len=100) :: dummy
    integer :: iostat
    totval = 0

    open(unit=10, file=input_file, status="old", action="read")
    read(10, *)  ! Skip header lines
    read(10, *) 
    read(10, *) 
    read(10, *) 
    read(10, *) dummy, dummy, dummy, dummy, n, dummy, m
    do
      read(10, '(A)', iostat=iostat)
      if (iostat /= 0) exit
      totval = totval + 1
    end do
    close(10)
  end subroutine get_dimension

  subroutine read_matrix(input_file, totval, row, col, val)
    character(len=100), intent(in) :: input_file
    double precision, allocatable, intent(out) :: row(:), col(:), val(:)
    integer, intent(out) :: totval
    integer :: i, i_stat

    allocate(row(totval), col(totval), val(totval), stat=i_stat)
    if (i_stat /= 0) then
      print *, "Error: Memory allocation failed for matrix data"
      stop
    end if
    open(unit=10, file=input_file, status="old", action="read")
    read(10, *)  ! Skip header lines
    read(10, *) 
    read(10, *) 
    read(10, *) 
    read(10, *) 
    do i = 1, totval
      read(10, *) row(i), col(i), val(i)
    end do
    close(10)
  end subroutine read_matrix

  subroutine dense_matrix(n, m, row, col, val, totval, dense)
    integer, intent(in) :: n, m, totval
    double precision, allocatable, intent(in) :: row(:), col(:), val(:)
    double precision, allocatable, intent(out) :: dense(:,:)
    integer :: i, j, k, i_stat

    allocate(dense(n, m), stat=i_stat)
    if (i_stat /= 0) then
      print *, "Error: Memory allocation failed for dense matrix"
      stop
    end if
    dense = 0.0d0
    do k = 1, totval
      i = int(row(k))
      j = int(col(k))
      dense(i, j) = val(k)
    end do
  end subroutine dense_matrix

  subroutine multiply_dense(nA, mA, denseA, mB, denseB, nC, mC, denseC)
    integer, intent(in) :: nA, mA, mB
    double precision, allocatable, intent(in) :: denseA(:,:), denseB(:,:)
    double precision, allocatable, intent(out) :: denseC(:,:)
    integer, intent(out) :: nC, mC
    integer :: i, j, k, i_stat

    nC = nA
    mC = mB
    allocate(denseC(nC, mC), stat=i_stat)
    if (i_stat /= 0) then
      print *, "Error: Memory allocation failed for denseC"
      stop
    end if
    denseC = 0.0d0
    do i = 1, nC
      do j = 1, mC
        do k = 1, mA
          denseC(i, j) = denseC(i, j) + denseA(i, k) * denseB(k, j)
        end do
      end do
    end do
  end subroutine multiply_dense

  subroutine multiply_sparse(rowA, colA, valA, totvalA, rowB, colB, valB, totvalB, rowR, colR, valR, totvalR, nmult)
    double precision, allocatable, intent(in) :: rowA(:), colA(:), valA(:)
    double precision, allocatable, intent(in) :: rowB(:), colB(:), valB(:)
    double precision, allocatable, intent(out) :: rowR(:), colR(:), valR(:)
    integer, intent(in) :: totvalA, totvalB
    integer, intent(out) :: totvalR, nmult
    integer :: i, j, k, i_stat

    allocate(rowR(totvalA * totvalB), colR(totvalA * totvalB), valR(totvalA * totvalB), stat=i_stat)
    if (i_stat /= 0) then
      print *, "Error: Memory allocation failed for sparse result matrix"
      stop
    end if
    nmult = 0
    totvalR = 0
    do i = 1, totvalA
      do j = 1, totvalB
        if (colA(i) == rowB(j)) then
          nmult = nmult + 1
          totvalR = totvalR + 1
          rowR(totvalR) = rowA(i)
          colR(totvalR) = colB(j)
          valR(totvalR) = valA(i) * valB(j)
        end if
      end do
    end do
  end subroutine multiply_sparse

END PROGRAM matrixmultiplication
