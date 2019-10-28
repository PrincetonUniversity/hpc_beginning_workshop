# HPC Quick Start

This quick start guide provides a demonstration of how to transfer your files to Adroit and run a job using the Slurm scheduler. There are examples for both Python and R scripts. To obtain the example materials, run this command in a terminal on your **local machine**:

```
$ git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop
```

## Python Script Example

### On Your Local Machine

In a terminal on your laptop, change the working directory and examine the scripts:

```
$ cd hpc_beginning_workshop/00_quick_start/python_example
$ cat matrix_inversion.py
$ cat job.slurm
```

Here are the contents of the script file:

```python
import numpy as np
N = 3
X = np.random.randn(N, N)
print("X =\n", X)
print("Inverse(X) =\n", np.linalg.inv(X))
```

Below is the Slurm script which prescribes the resource requirements for the Python script:

```bash
#!/bin/bash
#SBATCH --job-name=py-matinv     # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH -p introhpc              # REMOVE THIS LINE AFTER THE WORKSHOP

module purge
module load anaconda3

srun python matrix_inverse.py
```

Next, while still on your laptop, run the following ssh command to create a directory on Adroit (you need to replace `<YourNetID>` twice):

```
ssh <YourNetID>@adroit.princeton.edu "mkdir -p /scratch/network/<YourNetID>/python_test"
```

Transfer the Python and Slurm scripts to Adroit using the scp (secure copy) command:

```
scp matrix_inverse.py <YourNetID>@adroit.princeton.edu:/scratch/network/<YourNetID>/python_test
scp job.slurm <YourNetID>@adroit.princeton.edu:/scratch/network/<YourNetID>/python_test
```

Now everything is in place on Adroit. Let's connect to the head node of that cluster and submit the job.

### On Adroit

SSH to Adroit:

```
ssh <YourNetID>@adroit.princeton.edu
```

Change the working directory ($USER does not need to be replaced):

```
cd /scratch/network/$USER/python_test
```

List the files in the current directory:

```
ls -l
```

Submit the job by running the following command:

```
sbatch job.slurm
```

This will place your job in the queue. You can monitor the status of your job with `squeue -u <YourNetID>`. If the `ST` field is `PD` (pending) then your job is waiting for other jobs to finish. If you do not see it in the list then it has finished. After the job runs you can view the output with `cat slurm-<XXXXXX>.out`. You will receive an email when the job is finished if you entered your NetID in the Slurm script.

Here is the expected output:

```
X =
 [[-0.70101861  0.20261191  0.10836766]
 [ 0.86684552 -0.75347296 -0.52716024]
 [-0.02477092  0.21738458 -0.11216934]]
Inverse(X) =
 [[-2.01455049 -0.46828701  0.25452735]
 [-1.11588991 -0.82273617  2.78852862]
 [-1.71771528 -1.49105147 -3.56712226]]
```

## R Script Example

### On Your Local Machine

In a terminal on your laptop, change the working directory and examine the scripts:

```
cd hpc_beginning_workshop/00_quick_start/R_example
$ cat data_analysis.R
$ cat job.slurm
$ head cdc.csv
```

Here is the R script:

```R
health = read.csv("cdc.csv")
print(summary(health))
```

Below is the Slurm script:

```
#!/bin/bash
#SBATCH --job-name=R-test        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multithread tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send mail when process begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH -p introhpc              # REMOVE THIS LINE AFTER THE WORKSHOP

srun Rscript data_analysis.R
```

Here are the first few lines of the data file (`cdc.csv`):

```
genhlth,exerany,hlthplan,smoke100,height,weight,wtdesire,age,gender
good,0,1,0,70,175,175,77,m
good,0,1,1,64,125,115,33,f
good,1,1,1,60,105,105,49,f
good,1,1,0,66,132,124,42,f
very good,0,1,0,61,150,130,55,f
very good,1,1,0,64,114,114,55,f
very good,1,1,0,71,194,185,31,m
very good,0,1,0,67,170,160,45,m
good,0,1,1,65,150,130,27,f
good,1,1,0,70,180,170,44,m
...
```

Next, while still on your laptop, run the following ssh command to create a directory on Adroit (you need to replace `<YourNetID>` twice):

```
ssh <YourNetID>@adroit.princeton.edu "mkdir -p /scratch/network/<YourNetID>/R_test"
```

Transfer the R script, Slurm script and data file to Adroit using the scp (secure copy) command:

```
scp data_analysis.R <YourNetID>@adroit.princeton.edu:/scratch/network/<YourNetID>/R_test
scp job.slurm <YourNetID>@adroit.princeton.edu:/scratch/network/<YourNetID>/R_test
scp cdc.csv <YourNetID>@adroit.princeton.edu:/scratch/network/<YourNetID>/R_test
```

### On Adroit

SSH to Adroit:

```
ssh <YourNetID>@adroit.princeton.edu
```

Change the working directory ($USER does not need to be replaced):

```
cd /scratch/network/$USER/R_test
```

List the files in the current directory:

```
ls -l
```

Submit the job by running the following command:

```
sbatch job.slurm
```

This will place your job in the queue. You can monitor the status of your job with `squeue -u <YourNetID>`. If the `ST` field is PD (pending) then your job is waiting for other jobs to finish. If you do not see it in the list then it has finished. After the job runs you can view the output with `cat slurm-<XXXXXX>.out`. You will receive an email when the job is finished if you entered your NetID in the Slurm script.

Here is the expected output:

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
