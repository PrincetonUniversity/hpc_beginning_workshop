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

Compile and run the CPU-only code:

```bash
$ cat laplace2d_cpu.c
$ gcc -o laplace2d_cpu laplace2d_cpu.c
$ ./laplace2d_cpu
```

### OpenACC on GPU

Compile the code with the following commands:

```
$ module load nvhpc/24.11
$ nvc -acc -gpu=cc80 -Minfo=accel -o laplace2d_acc laplace2d.c
$ ./laplace2d_acc
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
