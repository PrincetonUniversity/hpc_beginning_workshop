# Connecting to the Clusters via a Web Browser

Two of Princeton's HPC clusters–Adroit and Della–can be accessed via the web through the Open OnDemand web interface. If you are new to high-performance computing, this can be a good introductory way to start using the clusters.

In addition, this web option also opens up the possibility of using GUIs (Graphical User Interfaces) for programs such as  Jupyter, RStudio, MATLAB and Stata.

## Open OnDemand

To use the Open OnDemand web interface for Adroit or Della, you must first have an account set-up for the cluster you wish to use. (For instructions on how to gain access, navigate to the Adroit's or Della's webpage in the Systems submenu of the [Research Computing](https://researchcomputing.princeton.edu/) site.) Once you have an account, you can browse to [https://myadroit.princeton.edu](https://myadroit.princeton.edu) or [https://mydella.princeton.edu](https://mydella.princeton.edu), respectively.

Note that to access these links from off-campus you will need to use a [VPN](https://princeton.service-now.com/snap?id=kb_article&sys_id=ce2a27064f9ca20018ddd48e5210c745).

## Running a Terminal in Your Web Browser

To run commands on the Adroit head node, for example, browse to [MyAdroit](https://myadroit.princeton.edu/) and choose "Cluster" then "Adroit Cluster Shell Access".

![jupyter](images/terminal_two_frames.png)

**Users must follow the 10-10 rule on the head node of any cluster.** The 10-10 rule says that you can use up to 10% of the resources of the machine for up to 10 minutes. The head node of each cluster is shared by all users so this rule prevents someone from monopolizing the machine. The head nodes should only be used for light work such as installing software and doing short test runs. You may be contacted by a system administrator if you fail to observe the 10-10 rule.

## Running Jupyter, RStudio, MATLAB and Stata in Your Web Browser

To begin an interactive session with Jupyter, RStudio, MATLAB, or Stata, click on "Interactive Apps" in the top menu bar of your web browser.
When launching Jupyter, for example, you will need to click on "Interactive Apps" and then "Jupyter". You will need to choose the "Number of hours",
"Number of cores" and "Memory allocated". Set "Number of cores" to 1 unless you are sure that your script has been
explicitly parallelized. Click "Launch" and then when your session is ready click "Connect to Jupyter". Note that the more
resources you request, the more you will have to wait for your session to become available. When your session starts,
click on "New" in the upper right and choose "Python 3.7 [anaconda3/2019.10]" from the drop-down menu.

### Jupyter
![jupyter](images/jupyter_notebook.png)

### RStudio
![rstudio](images/rstudio_two_frames.png)

### MATLAB
![matlab](images/matlab_two_frames.png)

### Stata
![stata](images/stata_two_frames.png)
