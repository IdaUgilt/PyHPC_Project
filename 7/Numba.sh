#!/bin/bash
#BSUB -J Numba_test"                        # Job name
#BSUB -q hpc                                # Queue name
#BSUB -W 10                                 # Wall-clock time
#BSUB -R "rusage[mem=2GB]"                  # Resources
#BSUB -o Timer=NumbaCOrrect_%J.out                 # Output file (stdout)
#BSUB -e Timer=NumbaCOrrect_%J.err                 # Output file (stderr)
#BSUB -R "select[model==XeonGold6226R]"     # Select CPU model
#BSUB -n 1                                  # Select number of cores
#BSUB -R "span[hosts=1]"                    # Specify that the number of cores must be on the same host

# InitializePythonenvironment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613_2026

echo "time" > course_02613/Mini_projeckt/7/timings_static.txt

python3 Jacobi_numba.py 20

