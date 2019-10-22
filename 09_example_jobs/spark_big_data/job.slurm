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
