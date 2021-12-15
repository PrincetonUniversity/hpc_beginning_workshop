# OpenCL

Build the executable:

```
$ module load cudatoolkit/11.4
$ gcc -o hello hello.c -lOpenCL
```

Run the executable:

```
$ sbatch job.slurm
```
