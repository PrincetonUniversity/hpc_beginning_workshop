# Serial R Script

Here is a simple R script:

```R
health = read.csv("cdc.csv")
print(summary(health))
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=health-dat    # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

srun Rscript data_analysis.R
```

To run the R script, simply submit the job to the cluster:

```
$ sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
      genhlth        exerany          hlthplan         smoke100     
 excellent:4657   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 fair     :2019   1st Qu.:0.0000   1st Qu.:1.0000   1st Qu.:0.0000  
 good     :5675   Median :1.0000   Median :1.0000   Median :0.0000  
 poor     : 677   Mean   :0.7457   Mean   :0.8738   Mean   :0.4721  
 very good:6972   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
                  Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
     height          weight         wtdesire          age        gender   
 Min.   :48.00   Min.   : 68.0   Min.   : 68.0   Min.   :18.00   f:10431  
 1st Qu.:64.00   1st Qu.:140.0   1st Qu.:130.0   1st Qu.:31.00   m: 9569  
 Median :67.00   Median :165.0   Median :150.0   Median :43.00            
 Mean   :67.18   Mean   :169.7   Mean   :155.1   Mean   :45.07            
 3rd Qu.:70.00   3rd Qu.:190.0   3rd Qu.:175.0   3rd Qu.:57.00            
 Max.   :93.00   Max.   :500.0   Max.   :680.0   Max.   :99.00
```

Use `squeue -u $USER` to monitor queued jobs.

For HPC R jobs see this repo by Ben Hicks:  
[https://github.com/PrincetonUniversity/HPC_R_Workshop](https://github.com/PrincetonUniversity/HPC_R_Workshop)
