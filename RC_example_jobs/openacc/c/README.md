# OpenACC Example in C

Compile the code with the following commands:

```
$ module load pgi/19.5/64
$ pgcc -acc -ta=tesla:cc70 -Minfo=accel -o laplace2d_acc laplace2d.c
```

On TigerGPU, use `-ta=tesla:cc60`  and `#SBATCH --gres=gpu:1`.

Submit the job with:

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
