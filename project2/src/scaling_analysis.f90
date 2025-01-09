module scaling_analysis
  implicit none
  contains
 
  subroutine analyze_scaling(matrix_sizes, filling_degrees, sparse_times, dense_times, blas_times)
    integer, intent(in) :: matrix_sizes(:)
    real(8), intent(in) :: filling_degrees(:), sparse_times(:), dense_times(:), blas_times(:)
    integer :: i
 
    print *, "Scaling Analysis Results:"
    print *, "----------------------------------------"
    print *, "Size    Filling    Sparse Time    Dense Time    BLAS Time"
    do i = 1, size(matrix_sizes)
      print *, matrix_sizes(i), filling_degrees(i), sparse_times(i), dense_times(i), blas_times(i)
    end do
    print *, "----------------------------------------"
 
  end subroutine analyze_scaling
end module scaling_analysis
