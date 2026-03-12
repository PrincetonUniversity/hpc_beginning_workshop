# OpenACC Example in C

## Adroit

Connect and obtain the files:

```bash
$ ssh <YourNetID>@adroit-vis.princeton.edu
$ cd /scratch/network/$USER
$ git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop
$ cd hpc_beginning_workshop/openacc/c
```

### CPU Only

View, compile and run the CPU-only code:

```bash
$ cat laplace2d_cpu.c
$ gcc -o laplace2d_cpu laplace2d_cpu.c -lm
$ ./laplace2d_cpu
```

The expected output is

```
Jacobi relaxation Calculation: 4096 x 4096 mesh
    0, 0.250000
  100, 0.002397
  200, 0.001204
  300, 0.000804
  400, 0.000603
  500, 0.000483
  600, 0.000403
  700, 0.000345
  800, 0.000302
  900, 0.000269
 total: 236.502822 s
```

### OpenACC on GPU

Compile the code with the following commands:

```
$ module load nvhpc/24.11
$ nvc -acc -gpu=cc80 -Minfo=accel -o laplace2d_acc laplace2d.c
$ ./laplace2d_acc
```

Does the code run faster on the GPU? Try replacing `parallel loop` with `kernels` in the first pragma. How does the compiler report change? What happens if you comment out the `#pragma acc data`? In that case, is managed memory enough to give the same fast solution? To compile with managed memory:

```
$ nvc -acc -gpu=cc80,mem:managed -Minfo=accel -o laplace2d_acc laplace2d.c
```

## Della

Compile the code with the following commands:

```
$ ssh <YourNetID>@della-gpu.princeton.edu
$ module load nvhpc/24.5
$ nvc -acc -gpu=cc80 -Minfo=accel -o laplace2d_acc laplace2d.c   # A100
$ nvc -acc -gpu=cc90 -Minfo=accel -o laplace2d_acc laplace2d.c   # H100
```

Submit the job (make sure the correct `nvhpc` module is loaded in `job.slurm`):

```
$ sbatch job.slurm
```

The expected output is:

```
Jacobi relaxation Calculation: 4096 x 4096 mesh
    0, 0.250000
  100, 0.002397
  200, 0.001204
  300, 0.000804
  400, 0.000603
  500, 0.000483
  600, 0.000403
  700, 0.000345
  800, 0.000302
  900, 0.000269
 total: 1.080040 s
```
