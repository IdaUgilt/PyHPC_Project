#!/bin/bash
#BSUB -J ProfileJacobi                          # Job name
#BSUB -q hpc                                # Queue name
#BSUB -W 10                                 # Wall-clock time
#BSUB -R "rusage[mem=2GB]"                  # Resources
#BSUB -o profile_jacobi_N=5_%J.out                 # Output file (stdout)
#BSUB -e profile_jacobi_N=5_%J.err                 # Output file (stderr)
#BSUB -R "select[model==XeonGold6226R]"     # Select CPU model
#BSUB -n 1                                  # Select number of cores
#BSUB -R "span[hosts=1]"                    # Specify that the number of cores must be on the same host

# InitializePythonenvironment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613

# Run Python script
kernprof -l simulate.py 5
python -m line_profiler -rmt simulate.py.lprof