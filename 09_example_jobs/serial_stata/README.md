# Serial Stata script

Here is a simple Stata script (`hello_world.do`):

```stata
disp 2+2
```

The Slurm script (`job.slurm`) below is appropriate for serial Stata jobs:

```bash
#!/bin/bash
#SBATCH --job-name=stata         # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)

module purge
module load stata/16.0

stata -b hello_world.do
```

To run the Stata script, simply submit the job to the cluster:

```
$ sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
 /__    /   ____/   /   ____/
___/   /   /___/   /   /___/   16.0   Copyright 1985-2019 StataCorp LLC
  Statistics/Data Analysis            StataCorp
                                      4905 Lakeway Drive
                                      College Station, Texas 77845 USA
                                      800-STATA-PC        http://www.stata.com
                                      979-696-4600        stata@stata.com
                                      979-696-4601 (fax)

100-user Stata network perpetual license:
       Serial number:  401606267559
         Licensed to:  Stata/SE 16
                       100-user Network

Notes:
      1.  Stata is running in batch mode.
      2.  Unicode is supported; see help unicode_advice.

. do "hello_world.do" 

. display 2+2
4

. 
end of do-file
```

Use `squeue -u $USER` to monitor queued jobs.
