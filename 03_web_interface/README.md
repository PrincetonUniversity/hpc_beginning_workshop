# Open OnDemand

If you are new to high-performance computing then you will find that the simplest way to use Adroit or Della is
through the Open OnDemand web interface. If you have an account on Adroit or Della then browse
to [https://myadroit.princeton.edu](https://myadroit.princeton.edu) or
[https://mydella.princeton.edu](https://mydella.princeton.edu). If you need an account on Adroit then
complete [this form](https://forms.rc.princeton.edu/registration/?q=adroit). Note that to access these link from off-campus you will need to use a [VPN](https://princeton.service-now.com/snap?id=kb_article&sys_id=ce2a27064f9ca20018ddd48e5210c745).

## Running a Terminal in Your Web Browser

To run commands on the Adroit head node, for example, browse to [MyAdroit](https://myadroit.princeton.edu/) and choose "Cluster" then "Adroit Cluster Shell Access".

![jupyter](https://tigress-web.princeton.edu/~jdh4/terminal_two_frames.png)

**Users must follow the 10-10 rule on the head node of any cluster.** The 10-10 rule says that you can use up to 10% of the resources of the machine for up to 10 minutes. The head node of each cluster is shared by all users so this rule prevents someone from monopolizing the machine. The head notes should only be used for light work such as installing software and doing short test runs. You may be contacted by a system administrator if you fail to observe the 10-10 rule.

## Python, RStuido, MATLAB and XStata in a Web Browser

To begin a session, click on "Interactive Apps" and then "Jupyter". You will need to choose the "Number of hours",
"Number of cores" and "Memory allocated". Set "Number of cores" to 1 unless you are sure that your script has been
explicitly parallelized. Click "Launch" and then when your session is ready click "Connect to Jupyter". Note that the more
resources you request, the more you will have to wait for your session to become available. When your session starts,
click on "New" in the upper right and choose "Python 3.7 [anaconda3/2019.10]" from the drop-down menu.

![jupyter](https://tigress-web.princeton.edu/~jdh4/jupyter_notebook.png)
