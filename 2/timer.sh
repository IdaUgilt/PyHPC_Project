#!/bin/bash
#BSUB -J timer_new                          # Job name
#BSUB -q hpc                                # Queue name
#BSUB -W 120                                 # Wall-clock time
#BSUB -R "rusage[mem=25GB]"                  # Resources
#BSUB -o Timer_new%J.out                 # Output file (stdout)
#BSUB -e Timer_new%J.err                 # Output file (stderr)
#BSUB -n 1                                  # Select number of cores
#BSUB -R "span[hosts=1]"                    # Specify that the number of cores must be on the same host

# InitializePythonenvironment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613_2026

echo "time" > /zhome/a5/0/187476/course_02613/Mini_projeckt/2/timings_static.txt

python3 simulate.py 20
