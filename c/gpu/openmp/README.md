# Compiling a C code to use OpenMP on a GPU

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

One can compile the code with the following commands:

```bash
$ ssh <YourNetID>@tigergpu.princeton.edu
$ module load nvhpc/21.5
$ nvc -mp=gpu -gpu=cc60 -Minfo=mp hello_world_omp.c 
main:
      8, #omp target parallel
          8, Generating "nvkernel_main_F1L8_1" GPU kernel
```

Submit the job:

```
$ sbatch job.slurm
```

Use `-gpu=cc70` for the V100 GPU and `-gpu=cc80` for the A100 GPU.
