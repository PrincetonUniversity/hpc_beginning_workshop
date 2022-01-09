# OpenCL

Build the executable:

```
$ module load cudatoolkit/11.4
$ gcc -o hello hello.c -lOpenCL
```

Run the executable:

```
# use a text editor to enter your email address in job.slurm
$ sbatch job.slurm
```
