module performance_analysis
  implicit none
  contains
 
  subroutine analyze_performance(sparse_time, dense_time, blas_time, matrix_size, filling_degree)
    real(8), intent(in) :: sparse_time, dense_time, blas_time
    integer, intent(in) :: matrix_size
    real(8), intent(in) :: filling_degree
 
    print *, "Performance Analysis Results:"
    print *, "----------------------------------------"
    print *, "Matrix Size:", matrix_size
    print *, "Filling Degree:", filling_degree
    print *, "Sparse Multiplication Time:", sparse_time, " seconds"
    print *, "Dense Multiplication Time:", dense_time, " seconds"
    print *, "BLAS Multiplication Time:", blas_time, " seconds"
    print *, "----------------------------------------"
 
  end subroutine analyze_performance
end module performance_analysis
