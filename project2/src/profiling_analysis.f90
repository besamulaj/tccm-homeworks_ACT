module profiling_analysis
  implicit none
  contains
 
  subroutine profile_methods(sparse_time, dense_time, blas_time, matrix_size)
    real(8), intent(in) :: sparse_time, dense_time, blas_time
    integer, intent(in) :: matrix_size
    real(8) :: efficiency_sparse, efficiency_dense, efficiency_blas
 
    ! Compute efficiencies relative to size
    efficiency_sparse = matrix_size / sparse_time
    efficiency_dense = matrix_size / dense_time
    efficiency_blas = matrix_size / blas_time
 
    print *, "Profiling Results:"
    print *, "----------------------------------------"
    print *, "Matrix Size:", matrix_size
    print *, "Sparse Efficiency:", efficiency_sparse, " elements/sec"
    print *, "Dense Efficiency:", efficiency_dense, " elements/sec"
    print *, "BLAS Efficiency:", efficiency_blas, " elements/sec"
    print *, "----------------------------------------"
 
  end subroutine profile_methods
end module profiling_analysis
