module multiply_dense_matrix
    implicit none
contains
    subroutine dense_multiply(A, B, Result)
        real(8), intent(in) :: A(:,:), B(:,:)
        real(8), intent(out) :: Result(size(A,1), size(B,2))
        integer :: i, j, k
 
        Result = 0.0d0
        do i = 1, size(A,1)
            do j = 1, size(B,2)
                do k = 1, size(A,2)
                    Result(i,j) = Result(i,j) + A(i,k) * B(k,j)
                end do
            end do
        end do
    end subroutine dense_multiply
end module multiply_dense_matrix
