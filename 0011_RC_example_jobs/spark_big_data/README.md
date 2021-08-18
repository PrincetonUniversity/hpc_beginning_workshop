# Using Spark

First obtain a simple Python script that uses Spark by running the following command:

```
wget https://raw.githubusercontent.com/apache/spark/master/examples/src/main/python/pi.py
```

Below is the Slurm script (`job.slurm`):

```bash
#!/bin/bash
#SBATCH --job-name=spark-pi      # create a short name for your job
#SBATCH --nodes=2                # node count
#SBATCH --ntasks-per-node=3      # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=12G                # memory per node
#SBATCH --time=00:00:30          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3 spark

spark-start
spark-submit --total-executor-cores 24 --executor-memory 4G pi.py 100
```

To run the Python script, simply submit the job to the cluster by running the following command:

```
$ sbatch job.slurm
```

The output of the code (minus the INFO statements) should be:

```
...
Pi is roughly 3.141376
...
```

Here is a getting started guide with Spark at Princeton:  
[https://researchcomputing.princeton.edu/faq/spark-via-slurm](https://researchcomputing.princeton.edu/faq/spark-via-slurm)
