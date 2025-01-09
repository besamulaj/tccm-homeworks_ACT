program sparse_to_dense_convert
    implicit none
    integer, parameter :: nrows = 5, ncols = 5
    integer, allocatable :: rows(:), cols(:)
    real(8), allocatable :: values(:)
    real(8) :: dense_matrix(nrows, ncols)
    integer :: count, i, j
 
    ! Example sparse matrix input
    count = 4
    allocate(rows(count), cols(count), values(count))
    rows = [1, 2, 3, 4]
    cols = [1, 2, 3, 4]
    values = [10.0d0, 20.0d0, 30.0d0, 40.0d0]
 
    ! Display the sparse matrix
    print *, "Sparse Matrix Representation (Row, Column, Value):"
    do i = 1, count
        print *, "(", rows(i), ",", cols(i), ",", values(i), ")"
    end do
 
    ! Initialize the dense matrix with zeros
    dense_matrix = 0.0d0
 
    ! Convert sparse to dense
    call sparse_to_dense(rows, cols, values, count, dense_matrix, nrows, ncols)
 
    ! Display the dense matrix
    print *, "This sparse matrix has been converted into a dense matrix:"
    print *, "Dense Matrix Representation:"
    do i = 1, nrows
        do j = 1, ncols
            write(*, "(F8.2)", advance="no") dense_matrix(i, j)
        end do
        print *
    end do
 
    ! Deallocate the arrays
    deallocate(rows, cols, values)
 
contains
 
    subroutine sparse_to_dense(rows, cols, values, count, dense_matrix, nrows, ncols)
        implicit none
        integer, intent(in) :: rows(:), cols(:), count, nrows, ncols
        real(8), intent(in) :: values(:)
        real(8), intent(inout) :: dense_matrix(nrows, ncols)
        integer :: i
 
        ! Populate the dense matrix using sparse representation
        do i = 1, count
            dense_matrix(rows(i), cols(i)) = dense_matrix(rows(i), cols(i)) + values(i)
        end do
    end subroutine sparse_to_dense
 
end program sparse_to_dense_convert
