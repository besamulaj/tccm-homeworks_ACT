module sparse_to_dense
    implicit none
contains
    subroutine sparse_dense(rows, cols, values, nrows, ncols, dense_matrix)
        integer, intent(in) :: rows(:), cols(:), nrows, ncols
        real(8), intent(in) :: values(:)
        real(8), intent(out), allocatable :: dense_matrix(:,:)
        integer :: i
 
        ! Validate dimensions
        if (nrows <= 0 .or. ncols <= 0) then
            print *, "Error: Invalid matrix dimensions for dense matrix."
            stop
        end if
 
        ! Allocate the dense matrix and initialize to zero
        allocate(dense_matrix(nrows, ncols))
        dense_matrix = 0.0d0
 
        ! Populate the dense matrix with values
        do i = 1, size(values)
            if (rows(i) > 0 .and. rows(i) <= nrows .and. cols(i) > 0 .and. cols(i) <= ncols) then
                dense_matrix(rows(i), cols(i)) = values(i)
            else
                print *, "Error: Invalid index in sparse matrix (", rows(i), ",", cols(i), ")."
                stop
            end if
        end do
    end subroutine sparse_dense
end module sparse_to_dense
