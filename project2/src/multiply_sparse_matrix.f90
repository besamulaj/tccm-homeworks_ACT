program multiply_sparse_matrix
    implicit none
    integer, allocatable :: rows(:), cols(:), result_rows(:), result_cols(:)
    real(8), allocatable :: values(:), result_values(:)
    integer :: i, j, k, n, result_count, estimated_size
    character(len=256) :: file_name
 
    ! Prompt user for the file name
    print *, "Enter the file name:"
    read(*, '(A)') file_name
 
    ! Read the sparse matrix from the file
    call read_sparse_matrix(file_name, rows, cols, values, n)
 
    ! Allocate arrays for results
    estimated_size = 2 * n
    allocate(result_rows(estimated_size), result_cols(estimated_size), result_values(estimated_size))
    result_count = 0
 
    ! Perform sparse matrix multiplication (A * A^T)
    do i = 1, n
        do j = 1, n
            if (cols(i) == rows(j)) then
                result_count = result_count + 1
                if (result_count > size(result_rows)) then
                    call resize_integer_array(result_rows, result_count)
                    call resize_integer_array(result_cols, result_count)
                    call resize_real_array(result_values, result_count)
                end if
                result_rows(result_count) = rows(i)
                result_cols(result_count) = cols(j)
                result_values(result_count) = values(i) * values(j)
            end if
        end do
    end do
 
    ! Output the result matrix in sparse format
    print *, "Result matrix (sparse format):"
    do i = 1, result_count
        print *, result_rows(i), result_cols(i), result_values(i)
    end do
 
contains
 
    subroutine read_sparse_matrix(file_name, rows, cols, values, n)
        implicit none
        character(len=256), intent(in) :: file_name
        integer, allocatable, intent(out) :: rows(:), cols(:)
        real(8), allocatable, intent(out) :: values(:)
        integer, intent(out) :: n
        integer :: ios, row, col, count
        real(8) :: val
 
        ! Open the file
        open(unit=10, file=trim(file_name), status="old", action="read", iostat=ios)
        if (ios /= 0) then
            print *, "Error opening file. Please check the file name."
            stop
        end if

        ! Count the number of non-zero entries
        count = 0
        do
            read(10, *, iostat=ios) row, col, val
            if (ios /= 0) exit
            count = count + 1
        end do
        rewind(10)

        n = count
        allocate(rows(n), cols(n), values(n))
 
        ! Read the matrix data
        count = 0
        do
            read(10, *, iostat=ios) row, col, val
            if (ios /= 0) exit
            count = count + 1
            rows(count) = row
            cols(count) = col
            values(count) = val
        end do
 
        close(10)
    end subroutine read_sparse_matrix
 
    subroutine resize_integer_array(array, current_size)
        implicit none
        integer, allocatable, intent(inout) :: array(:)
        integer, intent(in) :: current_size
        integer, allocatable :: temp(:)
        integer :: new_size
 
        new_size = 2 * current_size
        allocate(temp(new_size))
        temp = 0
        temp(1:size(array)) = array
        deallocate(array)
        allocate(array(new_size))
        array = temp
    end subroutine resize_integer_array
 
    subroutine resize_real_array(array, current_size)
        implicit none
        real(8), allocatable, intent(inout) :: array(:)
        integer, intent(in) :: current_size
        real(8), allocatable :: temp(:)
        integer :: new_size
 
        new_size = 2 * current_size
        allocate(temp(new_size))
        temp = 0.0d0
        temp(1:size(array)) = array
        deallocate(array)
        allocate(array(new_size))
        array = temp
    end subroutine resize_real_array
 
end program multiply_sparse_matrix
