!
!  Copyright 2012 NVIDIA Corporation
!
!  Licensed under the Apache License, Version 2.0 (the "License");
!  you may not use this file except in compliance with the License.
!  You may obtain a copy of the License at
!
!      http://www.apache.org/licenses/LICENSE-2.0
!
!  Unless required by applicable law or agreed to in writing, software
!  distributed under the License is distributed on an "AS IS" BASIS,
!  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!  See the License for the specific language governing permissions and
!  limitations under the License.
!

program laplace
  implicit none
  integer, parameter :: fp_kind=kind(1.0d0)
  integer, parameter :: n=1024, m=1024, iter_max=1000
  integer :: i, j, iter
  real(fp_kind), dimension (:,:), allocatable :: A, Anew
  real(fp_kind) :: tol=1.0e-6_fp_kind, error=1.0_fp_kind
  real(fp_kind) :: start_time, stop_time

  allocate ( A(0:n-1,0:m-1), Anew(0:n-1,0:m-1) )

  A    = 0.0_fp_kind
  Anew = 0.0_fp_kind

  ! Set B.C.
  A(0,:)    = 1.0_fp_kind
  Anew(0,:) = 1.0_fp_kind
   
  write(*,'(a,i5,a,i5,a)') 'Jacobi relaxation Calculation:', n, ' x', m, ' mesh'
 
  call cpu_time(start_time) 

  iter=0

!$acc data copyin(Anew), copy(A)
  do while ( error .gt. tol .and. iter .lt. iter_max )
    error=0.0_fp_kind

!$acc kernels
    do j=1,m-2
      do i=1,n-2
        Anew(i,j) = 0.25_fp_kind * ( A(i+1,j  ) + A(i-1,j  ) + &
                                     A(i  ,j-1) + A(i  ,j+1) )
        error = max( error, abs(Anew(i,j)-A(i,j)) )
      end do
    end do
!$acc end kernels

    if(mod(iter,100).eq.0 ) write(*,'(i5,f10.6)'), iter, error
    iter = iter + 1

!$acc kernels
    do j=1,m-2
      do i=1,n-2
        A(i,j) = Anew(i,j)
      end do
    end do
!$acc end kernels

  end do
!$acc end data

  call cpu_time(stop_time) 
  write(*,'(a,f10.3,a)')  ' completed in ', stop_time-start_time, ' seconds'

  deallocate (A,Anew)
end program laplace
