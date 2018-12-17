# A pandas example using SLURM
This is a trivial Pandas example using the Princeton RC
cluster environment through SLURM. You'll want to create two files: a python
script in your home directory named `pandas_example.py` and a SLURM script
called `pandas_example.cmd`

## The Python Script
```{python}
import pandas as pd
import numpy as np

'''
Example script taken from https://pandas.pydata.org/pandas-docs/stable/10min.html
'''
# Make an array with six dates and 4 arbitrary random numbers as 'observations'
dates = pd.date_range('20130101', periods=6)
# Parse into a pandas dataframe
df = pd.DataFrame(np.random.randn(6,4), index=dates, columns=list('ABCD'))

# print the short data frame to stdout
print(df)
```

## The Slurm script
```{bash}
#!/bin/bash
# serial job using 1 node, 1 core
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 0:01:00
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=yourNetID@princeton.edu

# Load anaconda for python 3 (which has a version of pandas already installed)
module load anaconda3
# Make sure we're in home and then run the example script sitting there
cd $HOME && python pandas_example.py
```

## Running the job

Once you have this in the appropriate files, from `~` (`$HOME`), you can run
`sbatch pandas_example.cmd` and SLURM will slate your job to run on a compute
node. It will then write the contents of the dataframe (in printed format) to
`slurm-jobnumber.out` in your home dir.
