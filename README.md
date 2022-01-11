# Getting Started with the Research Computing Clusters - Running Example Jobs on the HPC Clusters

## About
This resource provides example jobs that can be run on Princeton University's Research Comptuing clusters. 

## Useful links

* [Getting Started with HPC at Princeton](https://researchcomputing.princeton.edu/getting-started) - Landing page for getting started with our clusters.    
* [Research Computing KnowledgeBase](https://researchcomputing.princeton.edu/support/knowledge-base) - Search all of our help articles for using the clusters at Princeton.  
* [Research Computing FAQ](https://researchcomputing.princeton.edu/support/faq) - View answers to frequently asked questions.  
* [Research Computing Support Page](https://researchcomputing.princeton.edu/support) - Where to go if you need more help. 

<!--
## Survey Link

Please fill out our [survey for the Fall 2021 workshop](https://docs.google.com/forms/d/e/1FAIpQLSfBLpW9f5VEPikTR9MCPrw4hSKX2eCrFr1Ri0hiqDokR8qXNg/viewform).

## Authorship

This guide was created by Ben Hicks. It has been extended and modified by Jonathan Halverson, Gabe Perez-Giz,  Carolina Roe-Raymond, and Calla Chennault. Some of the content was originally written by Uno Vaaland.

## Workshop Survey
[Click here](https://bit.ly/hpcintro_24feb20)
-->

# Running Example Jobs on the HPC Clusters

The sample jobs above are written with Nobel, Adroit, Della, Stellar, and Tiger in mind. You will probably need to use different environment modules on Traverse.

Follow the directions below to begin running simple jobs on Adroit.
After SSHing to Adroit the first step is to `cd` (change directory)
to your directory on `/scratch/network/<YourNetID>`. We do this because `/scratch/network`
is a much faster filesystem with more space than `/home`.

```
ssh <YourNetID>@adroit.princeton.edu  # vpn required from off-campus
cd /scratch/network/<YourNetID>  # on tiger, della or stellar replace /scratch/network/ with /scratch/gpfs/
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop
cd hpc_beginning_workshop
```

Then choose an example and follow the directions. For instance:

```
cd python/cpu
cat README.md
```

For more detailed instructions on running an example Python or R job, see the [First Slurm Job](https://researchcomputing.princeton.edu/get-started/guide-princeton-clusters/3-first-slurm-job) section of the [Guide to the Princeton Clusters](https://researchcomputing.princeton.edu/get-started/guide-princeton-clusters).

## Where to store your files

To familiarize yourself with the cluster's file systems and where to store to your files, review our [Data Storage](https://researchcomputing.princeton.edu/support/knowledge-base/data-storage) page.

**IMPORTANT**: *You should run your jobs out of /scratch/network on Adroit and /scratch/gpfs on the other clusters. These filesystems are very fast and provide vast amounts of storage. Do not run jobs out of /tigress or /projects. These filesystems are slow and should only be used for backing-up the files that you produce on /scratch/gpfs or /scratch/network. Your /home directory on all clusters is small should only be used for storing source code, executables, Conda environments and small data sets*.

