#!/bin/bash
#BSUB -J gpu_simulate                          # Job name
#BSUB -q c02613                                # Queue name
#BSUB -W 00:30                                 # Wall-clock time
#BSUB -R "rusage[mem=1GB]"                 # Resources
#BSUB -o gpu_simulate_%J.out                  # Output file (stdout)
#BSUB -e gpu_simulate_%J.err                  # Output file (stderr)
#BSUB -n 4                                  # Select number of cores
#BSUB -R "span[hosts=1]"                    # Specify that the number of cores must be on the same host
#BSUB -gpu "num=1:mode=exclusive_process"

# InitializePythonenvironment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613_2026

python simulate_kernel.py 20 > results_kernel.csv