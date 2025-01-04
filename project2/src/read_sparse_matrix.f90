program read_sparse_matrix
    implicit none
    integer, parameter :: max_entries = 10000  ! Adjust based on matrix size
    integer, parameter :: max_metadata_lines = 5  ! Allow up to 5 lines of metadata
    integer :: i, n, metadata_lines, row, col
    real(8) :: value
    integer, dimension(max_entries) :: rows, cols
    real(8), dimension(max_entries) :: values
    character(len=256) :: filename
    character(len=256) :: current_line

    ! Input file name
    print *, "Enter the file name: "
    read(*,*) filename

    open(unit=10, file=filename, status='old')
    metadata_lines = 0
    do i =1, max_metadata_lines
        read(10, '(A)', iostat=line_check) current_line
        if (line_check /= 0) exit
        if (verify(adjust(current_line) '123456789') /= 0) then
            metadata_lines = metadata_lines + 1
        else
            rewind(10)
            exit
        end if
    end do

    ! Read the data
    n = 0
    do
        read(10, *, iostat=line_check) row, col, value
        if (line_check /= 0) exit
        n = n + 1
        rows(n) = row
        cols(n) = col
        values(n) = value
    end do
    close(10)

    ! Print the data for verification
    print *, "Sparse matrix read successfully!"
    do i = 1, n
        print *, rows(i), cols(i), values(i)
    end do
    
end program read_sparse_matrix
