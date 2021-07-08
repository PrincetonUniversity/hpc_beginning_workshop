program hello_world_multithreaded
use omp_lib

!$omp parallel

    write(*,*) "Hello from process ", omp_get_thread_num(), " of ", omp_get_num_threads()

!$omp end parallel

end program
