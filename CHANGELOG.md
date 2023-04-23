# V1.0
added batchsize option which is used to group intervals before creating scatter jobs.  within each scatter job, the set of intervals is processed sequentially.
this is to better balance the number of jobs (intervals x samples) at any one time that are submitted for this workflow at any one time
# Unreleased - 05-11-2022
Changed bed and panel type
# Unreleased - 01-07-2022
Stronger calculate script
# Unreleased - 01-06-2022
Migrate to Vidarr
