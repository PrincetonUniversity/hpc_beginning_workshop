# Planning your jobs

[Table of Contents](/hpc_beginning_workshop/)

Ask yourself:
  1. What are my needs?
  2. Do I need to do many single core jobs or their equivalent?
  3. If my job can be made parallel, how?
    1. Slice up data set
    2. Library parallelization through threading (matlab and a specially built R with MKL can do this, for example)
  4. How does this scale (i.e. can I make this work on 1 core, 2 cores, 3, more?)

Allow yourself:
  * Time to experiment on code
  * Use of good version control like a [Github
  repo hosted by Princeton](https://www.princeton.edu/researchcomputing/services/github-form-new/)
  * Time to do some tests and studies to determine optimum run conditions -- the more you can pare down requirements the more efficiently you can run.
  * Time to look at different approaches.
