# OpenACC Example in Fortran

Compile the code with the following commands:

```
$ module load pgi/19.5/64
$ pgfortran -acc -ta=tesla:cc70 -Minfo=accel -o laplace2d_acc laplace2d.f90
```

On TigerGPU, use `-ta=tesla:cc60` and `#SBATCH --gres=gpu:1`.

Submit the job with:

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
