
program test_dense_multipy
    implicit none
    integer, parameter :: n = 3
    real(8) :: matrix_a(n, n), matrix_b(n, n), result(n, n), expected(n, n)
    integer :: i, j, k
    logical :: is_correct

    ! Initialize matrices
    matrix_a = reshape([1.0d0, 2.0d0, 3.0d0, 4.0d0, 5.0d0, 6.0d0, 7.0d0, 8.0d0, 9.0d0], shape(matrix_a))
    matrix_b = reshape([9.0d0, 8.0d0, 7.0d0, 6.0d0, 5.0d0, 4.0d0, 3.0d0, 2.0d0, 1.0d0], shape(matrix_b))
    expected = reshape([90.0d0, 114.0d0, 138.0d0, 54.0d0, 69.0d0, 84.0d0, 18.0d0, 24.0d0, 30.0d0], shape(expected))

    ! Initialize result matrix to zero
    result = 0.0d0

    ! Perform matrix multiplication: result = matrix_a * matrix_b
    do i = 1, n
        do j = 1, n
            do k = 1, n
                result(i, j) = result(i, j) + matrix_a(i, k) * matrix_b(k, j)
            end do
        end do
    end do

    ! Print matrices and result
    print *, "Matrix A:"
    call print_matrix(matrix_a, n)

    print *, "Matrix B:"
    call print_matrix(matrix_b, n)

    print *, "Result of A * B:"
    call print_matrix(result, n)

    print *, "Expected Result:"
    call print_matrix(expected, n)

    ! Verify the result
    is_correct = .true.
    do i = 1, n
        do j = 1, n
            if (abs(result(i, j) - expected(i, j)) > 1.0d-6) then
                is_correct = .false.
            end if
        end do
    end do

    if (is_correct) then
        print *, "Test Passed: The multiplication result is correct!"
    else
        print *, "Test Failed: The multiplication result is incorrect."
    end if

contains

    subroutine print_matrix(matrix, n)
        implicit none
        real(8), intent(in) :: matrix(n, n)
        integer, intent(in) :: n
        integer :: i, j

        do i = 1, n
            do j = 1, n
                write(*, "(F8.2)", advance="no") matrix(i, j)
            end do
            print *
        end do
    end subroutine print_matrix

end program test_dense_multiply
