program main
  use performance_analysis
  use profiling_analysis
  use scaling_analysis
  use timing_analysis
  use sparse_to_dense
  use read_sparse_matrix
  use multiply_dense_matrix
  use multiply_sparse_matrix
  implicit none

  integer, parameter :: max_size = 10000
  real(8) :: sparse_time, dense_time, blas_time
  integer :: nrows_a, ncols_a, nrows_b, ncols_b
  real(8), allocatable :: dense_a(:,:), dense_b(:,:), dense_r(:,:)
  real(8), allocatable :: sparse_values_a(:), sparse_values_b(:)
  integer, allocatable :: sparse_rows_a(:), sparse_cols_a(:)
  integer, allocatable :: sparse_rows_b(:), sparse_cols_b(:)
  character(len=256) :: file_a, file_b
  integer :: result_count
  integer, allocatable :: result_rows(:), result_cols(:)
  real(8), allocatable :: result_values(:)

  ! Input filenames
  print *, "Enter the filename for matrix A:"
  read(*, '(A)') file_a
  print *, "Enter the filename for matrix B:"
  read(*, '(A)') file_b

  ! Debug: Print filenames to verify input
  print *, "Matrix A Filename:", trim(adjustl(file_a))
  print *, "Matrix B Filename:", trim(adjustl(file_b))


  ! Read sparse matrices
  call read_sparse_matrix(file_a, sparse_rows_a, sparse_cols_a, sparse_values_a, nrows_a, ncols_a)
  call read_sparse_matrix(file_b, sparse_rows_b, sparse_cols_b, sparse_values_b, nrows_b, ncols_b)

  ! Check for compatibility
  if (ncols_a /= nrows_b) then
    print *, "Error: Matrix dimensions are incompatible for multiplication"
    stop
  end if

  ! Allocation
  allocate(result_rows(nrows_a * ncols_b), result_cols(nrows_a * ncols_b), result_values(nrows_a * ncols_b))
  allocate(dense_a(nrows_a, ncols_a), dense_b(nrows_b, ncols_b))
  allocate(dense_r(nrows_a, ncols_b))

  ! Sparse multiplication timing
  call time_multiplication_sparse(sparse_multiply, sparse_time, &
       sparse_rows_a, sparse_cols_a, sparse_values_a, nrows_a, ncols_a, &
       sparse_rows_b, sparse_cols_b, sparse_values_b, nrows_b, ncols_b)

  ! Convert sparse matrices to dense
  allocate(dense_a(nrows_a, ncols_a))
  allocate(dense_b(nrows_b, ncols_b))
  call convert_sparse_to_dense(sparse_rows_a, sparse_cols_a, sparse_values_a, nrows_a, ncols_a, dense_a)
  call convert_sparse_to_dense(sparse_rows_b, sparse_cols_b, sparse_values_b, nrows_b, ncols_b, dense_b)
  call time_multiplication_dense(dense_multiply, dense_time, dense_a, dense_b, dense_r)

  ! Performance analysis
  call analyze_performance(sparse_time, dense_time, blas_time, &
       nrows_a * ncols_b, sum(sparse_values_a > 0) / real(nrows_a * ncols_a))

  ! Output results
  print *, "Sparse multiplication time: ", sparse_time
  print *, "Dense multiplication time: ", dense_time

  ! Cleanup
  deallocate(result_rows, result_cols, result_values, dense_a, dense_b, dense_r)
  
end program main
