module timing_analysis
 
! Direct use of intrinsic system_clock
    implicit none
  contains
 
  subroutine time_multiplication(multiply_method, elapsed_time)
    interface
      subroutine multiply_method()
      end subroutine multiply_method
    end interface
    real(8), intent(out) :: elapsed_time
    integer :: start, finish, rate
 
    call system_clock(count_rate=rate)
    call system_clock(count=start)
    call multiply_method()
    call system_clock(count=finish)
 
    elapsed_time = real(finish - start) / real(rate)
  end subroutine time_multiplication
end module timing_analysis
