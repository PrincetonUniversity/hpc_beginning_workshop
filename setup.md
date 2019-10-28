# Intro to HPC on the Princeton Clusters

## Setup for live workshop

### Point your browser to `https://bit.ly/32xY4nq`

+ Connect to the eduroam wireless network

+ Open a terminal (e.g., Terminal, PowerShell, PuTTY) [<a href="https://researchcomputing.princeton.edu/education/training/hardware-and-software-requirements-picscie-workshops" target="_blank">click here</a> for help]

+ SSH to Adroit in the terminal: `ssh <NetID>@adroit.princeton.edu`

+ Load this site in a web browser: [https://myadroit.princeton.edu](https://myadroit.princeton.edu)

+ Clone this repo to your local machine:

   `git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop`

+ For the live workshop, to get priority access on Adroit, add this line to your Slurm scripts: `#SBATCH -p introhpc`
