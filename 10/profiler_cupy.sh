#!/bin/bash
#BSUB -J Numba_test"                        # Job name
#BSUB -q c02613                                # Queue name
#BSUB -gpu "num=1:mode=exclusive_process"
#BSUB -W 10                                 # Wall-clock time
#BSUB -R "rusage[mem=2GB]"                  # Resources
#BSUB -o nsys_profiler_%J.out                 # Output file (stdout)
#BSUB -e nsys_profiler_%J.err                 # Output file (stderr)
#BSUB -n 4                                  # Select number of cores
#BSUB -R "span[hosts=1]"                    # Specify that the number of cores must be on the same host

# InitializePythonenvironment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613_2026

nsys profile -o double_prof python simulate_cupy.py 20