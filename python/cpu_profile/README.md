# Serial Python Script

Here is the simple Python script from the cpu folder reimagined with a main function:

```python
import numpy as np

@profile
def main():
    N = 2500
    X = np.random.randn(N, N)
    print("X =\n", X)
    print("Inverse(X) =\n", np.linalg.inv(X))

if __name__ == "__main__":
    main()
```

Below is the Slurm script; note that "python" has been replaced with "kernprof -l":

```bash
#!/bin/bash
#SBATCH --job-name=matinv        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3/2023.9

kernprof -l  matrix_inverse.py
```

To run the Python script and profile it, simply submit the job to the cluster:

```
$ sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
X =
 [[-0.21078117  0.62769243  0.28837545 ... -1.03865998  1.28583127
  -0.74421707]
 [ 2.45357122 -0.20869054  0.75988524 ... -0.56200297 -0.29385017
   1.1681604 ]
 [-0.28152259  0.11603482  0.05560238 ... -0.61087397  1.89416779
   0.67430558]
 ...
 [ 0.16107467 -0.77781874 -1.49761843 ... -1.66809409  1.10388892
  -2.04136392]
 [-0.38812641 -1.49357674 -0.20200282 ...  0.12990364 -0.06396706
  -1.17792409]
 [-0.22349287 -0.74146913  0.3457983  ...  0.25019033  0.04845655
   0.51799794]]
Inverse(X) =
 [[ 0.00491393 -0.01683183 -0.00961631 ...  0.00588857  0.00657472
  -0.01685872]
 [ 0.00777699  0.04024256  0.00819753 ...  0.00815894 -0.00532195
   0.01528094]
 [ 0.00816564 -0.005238   -0.01085497 ...  0.01056616  0.00716419
  -0.01077231]
 ...
 [ 0.03311148 -0.00594447  0.00066153 ... -0.02517066  0.00965069
  -0.01384705]
 [ 0.01846379  0.00834175 -0.00495258 ...  0.00833764 -0.00252175
  -0.01832523]
 [-0.00693749  0.0500026   0.00242409 ... -0.02713682 -0.03931025
   0.04234392]]
Wrote profile results to matrix_inverse.py.lprof
Inspect results with:
python -m line_profiler -rmt "matrix_inverse.py.lprof"
```

View the profile using the command listed above:
```
Timer unit: 1e-06 s

Total time: 1.50471 s
File: matrix_inverse.py
Function: main at line 3

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
     3                                           @profile
     4                                           def main():
     5         1          1.5      1.5      0.0      N = 2500
     6         1     279205.6 279205.6     18.6      X = np.random.randn(N, N)
     7         1       1124.5   1124.5      0.1      print("X =\n", X)
     8         1    1224377.0    1e+06     81.4      print("Inverse(X) =\n", np.linalg.inv(X))
```

Use `squeue -u $USER` to monitor queued jobs.

# Guide

For more on working with Python see [this page](https://researchcomputing.princeton.edu/python).
For more on line_profiler, see [this page](https://researchcomputing.princeton.edu/python-profiling).
