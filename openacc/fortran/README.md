# OpenACC Example in Fortran

Compile the code with the following commands:

```
$ ssh <YourNetID>@della-gpu.princeton.edu
$ module load nvhpc/24.5
$ nvfortran -acc -gpu=cc80 -Minfo=accel -o laplace2d_acc laplace2d.f90   # A100 GPU
$ nvfortran -acc -gpu=cc90 -Minfo=accel -o laplace2d_acc laplace2d.f90   # H100 GPU
```

Submit the job (make sure the correct `nvhpc` module is loaded in `job.slurm`):

```
$ sbatch job.slurm
```

The expected output is:

```
Jacobi relaxation Calculation: 1024 x 1024 mesh
    0  0.250000
  100  0.002397
  200  0.001204
  300  0.000804
  400  0.000603
  500  0.000483
  600  0.000403
  700  0.000345
  800  0.000302
  900  0.000269
 completed in      0.277 seconds
```
