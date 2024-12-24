program read_sparse_matrix
    implicit none
    integer, parameter :: max_entries = 10000  ! Adjust based on matrix size
    integer :: i, n, row, col
    real(8) :: value
    integer, allocatable :: rows(:), cols(:)
    real(8), allocatable :: values(:)
    character(len=256) :: filename

    ! Input file name
    print *, "Enter the file name: "
    read(*,*) filename

    open(unit=10, file=filename, status='old')
    n = 0
    do
        read(10, *, iostat=i)
        if (i /= 0) exit
        n = n + 1
    end do
    rewind(10)
    
    allocate(rows(n), cols(n), values(n))

    ! Read the data
    do i = 1, n
        read(10, *) row, col, value
        rows(i) = row
        cols(i) = col
        values(i) = value
    end do
    close(10)

    ! Print the data for verification
    print *, "Sparse matrix read successfully!"
    do i = 1, n
        print *, rows(i), cols(i), values(i)
    end do
    
end program read_sparse_matrix
