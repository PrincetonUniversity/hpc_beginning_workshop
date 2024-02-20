# Multithreaded MATLAB

Execute these commands to run the example job:

```
$ cd hpc_beginning_workshop/matlab/multithreaded
# edit email address in job.slurm
$ sbatch job.slurm
```

Try different values of `cpus-per-task`. You should find that the code runs about twice as fast when 4 CPU-cores are used versus 2.

For more on MATLAB on the HPC clusters see [this page](https://researchcomputing.princeton.edu/matlab).

# Listener Callback Warnings

Your job succeeded if you see the line indicating `Elapsed Time` (this will be printed when `toc` is encountered)

You may be alarmed by the following, but this and all following output can be safely ignored:

`Warning: Error occurred while executing the listener callback for event
ObjectBeingDestroyed defined for class parallel.settings.Profile:
Invalid or deleted object.`

In a more professional script, tracking callbacks is encouraged; the gist of the error(s) is that Matlab is attempting to clean up objects that may already have been deleted.
