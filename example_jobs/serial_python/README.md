# Serial Python Script

Simply submit the job to the cluster:

```
sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
X =
 [[ 1.34903552  0.67843791 -0.43574188]
 [ 1.60554068  0.66067333 -0.38373032]
 [-1.54970008  1.28489254  0.14557173]]
Inverse(X) =
 [[ -1.93014233   2.15752707  -0.09023234]
 [ -1.18235524   1.56870044   0.59596897]
 [-10.11145687   9.12202091   0.64855209]]
```

Use `squeue -u $USER` to monitor queued jobs.
