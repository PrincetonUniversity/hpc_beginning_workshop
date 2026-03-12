# Running an OpenMP C code on a GPU

## Exercise 1

Below is a simple code example:

```C
#include <stdio.h>
#include <omp.h>

int main(int argc, char* argv[]) {
 
  #pragma omp target
  #pragma omp parallel
  {
  int id = omp_get_thread_num();
  int nthrds = omp_get_num_threads();
  printf("Hello from thread %d of %d\n", id, nthrds);
  }
  return 0;
}
```

Connect and obtain the files:

```bash
$ ssh <YourNetID>@adroit-vis.princeton.edu
$ cd /scratch/network/$USER
$ git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop
$ cd hpc_beginning_workshop/c/gpu/openmp
```

Build and run the executable:

```
$ module load nvhpc/24.11
$ nvc -mp=gpu -gpu=cc80 -Minfo=mp -o hw_omp_gpu hello_world_omp.c
main:
      8, #omp target parallel
          8, Generating "nvkernel_main_F1L8_1" GPU kernel
$ ./hw_omp_gpu
```

Use `-gpu=cc90` for H100 GPUs and `-gpu=cc80` for the A100 GPU.

## Exercise 2

View, compile and run the code:

```
$ cat laplace2d.c
$ nvc -mp=gpu -gpu=cc80 -Minfo=mp -o laplace2d_acc laplace2d.c
$ ./laplace2d_acc
``
