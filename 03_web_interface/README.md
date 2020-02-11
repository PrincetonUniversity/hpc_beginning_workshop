# Open OnDemand

If you are new to high-performance computing then you will find that the simplest way to use Adroit and Della is
through the Open OnDemand web interface. If you have an account on Adroit or Della then browse
to [https://myadroit.princeton.edu](https://myadroit.princeton.edu) or
[https://mydella.princeton.edu](https://mydella.princeton.edu). If you need an account on Adroit then
complete [this form](https://forms.rc.princeton.edu/registration/?q=adroit). Note that to access these link from off-campus you will need to use a [VPN](https://princeton.service-now.com/snap?id=kb_article&sys_id=ce2a27064f9ca20018ddd48e5210c745).

## Running a Terminal in Your Web Browser

To run commands on the Adroit head node, for example, browse to MyAdroit then choose "Cluster" then "Adroit Cluster Shell Access".

![jupyter](https://tigress-web.princeton.edu/~jdh4/terminal_two_frames.png)

## Running Python, R, MATLAB and XStata in a Web Browser

To begin a session, click on "Interactive Apps" and then "Jupyter". You will need to choose the "Number of hours",
"Number of cores" and "Memory allocated". Set "Number of cores" to 1 unless you are sure that your script has been
explicitly parallelized. Click "Launch" and then when your session is ready click "Connect to Jupyter". Note that the more
resources you request, the more you will have to wait for your session to become available. When your session starts,
click on "New" in the upper right and choose "Python 3.7 [anaconda3/2019.10]" from the drop-down menu.

![jupyter](https://tigress-web.princeton.edu/~jdh4/jupyter_notebook.png)
