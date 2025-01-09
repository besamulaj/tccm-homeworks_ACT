program test_sparse_multiply
  implicit none
  integer, parameter :: max_size = 100
  integer, dimension(max_size) :: rows, cols, result_rows, result_cols
  real(8), dimension(max_size) :: values, result_values
  integer :: count, result_count
 
  ! Initialize test data for sparse matrix
  rows(1:5) = [1, 2, 3, 4, 0]
  cols(1:5) = [1, 2, 3, 4, 0]
  values(1:5) = [1.0d0, 2.0d0, 3.0d0, 4.0d0, 0.0d0]
  count = 4
 
  ! Call the sparse matrix multiplication subroutine
  call multiply_sparse_matrix(rows, cols, values, result_rows, result_cols, result_values, count, result_count)
 
  ! Print the results
  print *, "Result Matrix (Sparse Format):"
  call print_sparse_matrix(result_rows, result_cols, result_values, result_count)
 
contains
 
  subroutine multiply_sparse_matrix(rows, cols, values, result_rows, result_cols, result_values, count, result_count)
    implicit none
    integer, intent(in) :: rows(:), cols(:), count
    real(8), intent(in) :: values(:)
    integer, intent(out) :: result_rows(:), result_cols(:), result_count
    real(8), intent(out) :: result_values(:)
    integer :: i, j, k, idx
 
    ! Temporary arrays to store results
    integer, dimension(size(rows)) :: temp_rows, temp_cols
    real(8), dimension(size(values)) :: temp_values
 
    idx = 0
    do i = 1, count
      do j = 1, count
        if (cols(i) == rows(j)) then
          idx = idx + 1
          temp_rows(idx) = rows(i)
          temp_cols(idx) = cols(j)
          temp_values(idx) = values(i) * values(j)
        end if
      end do
    end do
 
    ! Copy results to output arrays
    result_count = idx
    result_rows(1:result_count) = temp_rows(1:result_count)
    result_cols(1:result_count) = temp_cols(1:result_count)
    result_values(1:result_count) = temp_values(1:result_count)
  end subroutine multiply_sparse_matrix
 
  subroutine print_sparse_matrix(rows, cols, values, count)
    implicit none
    integer, intent(in) :: rows(:), cols(:), count
    real(8), intent(in) :: values(:)
    integer :: i
 
    do i = 1, count
      print *, rows(i), cols(i), values(i)
    end do
  end subroutine print_sparse_matrix
 
end program test_sparse_multiply
