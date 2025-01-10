module timing_analysis
    implicit none
  contains
 
  ! Subroutine to measure time for a dense matrix multiplication
  subroutine time_multiplication_dense(operation, time_taken, A, B, result)
    interface
      subroutine operation(A, B, result)
        real(8), intent(in) :: A(:,:), B(:,:)
        real(8), intent(out) :: result(:,:)
      end subroutine operation
    end interface
 
    real(8), intent(out) :: time_taken
    real(8), intent(in) :: A(:,:), B(:,:)
    real(8), intent(out) :: result(:,:)
 
    real(8) :: start_time, end_time
 
    ! Record start time
    call cpu_time(start_time)
 
    ! Perform the operation
    call operation(A, B, result)
 
    ! Record end time
    call cpu_time(end_time)
 
    ! Calculate elapsed time
    time_taken = end_time - start_time
  end subroutine time_multiplication_dense
 
  ! Subroutine to measure time for sparse matrix multiplication
    subroutine time_multiplication_sparse(operation, time_taken, sparse_rows_a, sparse_cols_a, sparse_values_a, &
                                      nrows_a, ncols_a, sparse_rows_b, sparse_cols_b, sparse_values_b, nrows_b, ncols_b, &
                                      result_rows, result_cols, result_values, result_count)
        interface
            subroutine operation(sparse_rows_a, sparse_cols_a, sparse_values_a, &
                             sparse_rows_b, sparse_cols_b, sparse_values_b, &
                             result_rows, result_cols, result_values, &
                             nrows_a, ncols_b, result_count)
                integer, intent(in) :: sparse_rows_a(:), sparse_cols_a(:), sparse_rows_b(:), sparse_cols_b(:)
                real(8), intent(in) :: sparse_values_a(:), sparse_values_b(:)
                integer, allocatable, intent(out) :: result_rows(:), result_cols(:)
                real(8), allocatable, intent(out) :: result_values(:)
                integer, intent(in) :: nrows_a, ncols_b
                integer, intent(out) :: result_count
           end subroutine operation
        end interface
 
        real(8), intent(out) :: time_taken
        integer, intent(in) :: sparse_rows_a(:), sparse_cols_a(:), sparse_rows_b(:), sparse_cols_b(:)
        real(8), intent(in) :: sparse_values_a(:), sparse_values_b(:)
        integer, allocatable, intent(out) :: result_rows(:), result_cols(:)  ! Must be allocatable
        real(8), allocatable, intent(out) :: result_values(:)               ! Must be allocatable
        integer, intent(in) :: nrows_a, ncols_a, nrows_b, ncols_b
        integer, intent(out) :: result_count
        real(8) :: start_time, end_time

        ! Record start time
        call cpu_time(start_time)
 
        ! Perform the operation
        call operation(sparse_rows_a, sparse_cols_a, sparse_values_a, &
                   sparse_rows_b, sparse_cols_b, sparse_values_b, &
                   result_rows, result_cols, result_values, &
                   nrows_a, ncols_b, result_count)
 
        ! Record end time
        call cpu_time(end_time)
 
        ! Calculate elapsed time
        time_taken = end_time - start_time
    end subroutine time_multiplication_sparse
end module timing_analysis
