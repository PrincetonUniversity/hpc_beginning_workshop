# Software

## Using Pre-Install Software with Environment Modules

Lots of software is already available on each cluster. To see the modules that are available run this commond:

```
$ module avail
```

Use the `module load <module name>` command to activate a module. For example:

```
$ julia
-bash: julia: command not found
$ module load julia
$ julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.2.0 (2019-08-20)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```

To compile a parallel code that uses the message-passing interface (MPI) you will need to load an MPI module. You can load the Intel compilers and Intel MPI library with:

```
$ module load intel intel-mpi
$ mpicc --version
icc (ICC) 19.0.3.199 20190206
Copyright (C) 1985-2019 Intel Corporation.  All rights reserved.
```

To see exactly what a module is doing use `module show <module name>`. Modules only change the values of environment variables. They do not install or un-install software. For example:

```
$ module show cudatoolkit
-------------------------------------------------------------------
/usr/local/share/Modules/modulefiles/cudatoolkit/9.2:

module-whatis	 Sets up cudatoolkit92 9.2 in your environment 
prepend-path	 PATH /usr/local/cuda-9.2/bin 
prepend-path	 LD_LIBRARY_PATH /usr/local/cuda-9.2/lib64:/usr/lib64/nvidia 
prepend-path	 LIBRARY_PATH /usr/local/cuda-9.2/lib64:/usr/lib64/nvidia 
prepend-path	 MANPATH /usr/local/cuda-9.2/doc/man 
append-path	 -d   LDFLAGS -L/usr/local/cuda-9.2/lib64 -L/usr/lib64/nvidia 
append-path	 -d   INCLUDE -I/usr/local/cuda-9.2/include 
append-path	 CPATH /usr/local/cuda-9.2/include 
append-path	 -d   FFLAGS -I/usr/local/cuda-9.2/include 
append-path	 -d   LOCAL_LDFLAGS -L/usr/local/cuda-9.2/lib64 -L/usr/lib64/nvidia 
append-path	 -d   LOCAL_INCLUDE -I/usr/local/cuda-9.2/include 
append-path	 -d   LOCAL_CFLAGS -I/usr/local/cuda-9.2/include 
append-path	 -d   LOCAL_FFLAGS -I/usr/local/cuda-9.2/include 
append-path	 -d   LOCAL_CXXFLAGS -I/usr/local/cuda-9.2/include 
-------------------------------------------------------------------
```

To see all the options run `module help` or see [this page](https://researchcomputing.princeton.edu/faq/using-environment-modules).

If you need software that is not installed, your will most likely have to do it yourself.

## A Word on Python

When you first log in to the cluster, the system Python is used by default:

```
$ python --version
Python 2.7.5

$ which python
/usr/bin/python
```

To load Anaconda Python you must load the module:

```
$ module load anaconda3
$ python --version
Python 3.7.3
$ which python
/usr/licensed/anaconda3/2019.3/bin/python
```

To see all the packages that are included in Anaconda Python run this command:

```
$ conda list
```

## A Word on R

To start R and then immediately exit:

```
$ R
> q()
```

Note that RStudio is available through the [MyAdroit](https://myadroit.princeton.edu) web portal.

## Where to install software

We recommend that your create a directory such as `/home/<YourNetID>/software` to build and store software. Your home directory is backed-up. Be sure to run the `checkquota` command regularly to make sure you have enough space.

## Installing Python Packages on the HPC Clusters

Simple Python packages can be installed using Pip:

```
$ module load anaconda3
$ pip install --user <package name>
```

For more complicated packages such as FEniCS, you may consider using Conda:

```
module load anaconda3
conda create --name fenics-env -c conda-forge fenics
conda activate fenics-env
```

See [this guide](https://github.com/PrincetonUniversity/installing_python_packages) for installing Python packages.

## Installing R Packages on the HPC Clusters

The HPC clusters use an old version of the GNU C/C++ compilers to provide stability. To install many R packages you will need a newer compiler. This can be accomplished by loading the `rh` module:

```
$ g++ --version
g++ (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
...

$ module load rh/devtoolset/7

$ g++ --version
g++ (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
...
```

After loading the `rh` module you can start R and install your packages, for example:

```
$ module load rh/devtoolset/7
$ R
> install.packages("argparse")
# answer yes to the two questions and then choose 66 as the CRAN mirror
> q()
```
