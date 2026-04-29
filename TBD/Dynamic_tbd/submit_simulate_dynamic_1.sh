#!/bin/bash
#BSUB -J simulate_dynamic_1                   # Job name
#BSUB -q hpc                               # Queue name
#BSUB -W 03:00                             # Wall-clock time
#BSUB -R "rusage[mem=1GB]"                 # Resources
#BSUB -o simulate_dynamic_1_%J.out            # Output file (stdout)
#BSUB -e simulate_dynamic_1_%J.err            # Output file (stderr)
#BSUB -R "select[model==XeonGold6226R]"    # Select CPU model
#BSUB -n 32                                # Select number of cores
#BSUB -R "span[hosts=1]"                   # Specify that the number of cores must be on the same host

# InitializePythonenvironment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613

echo "n_proc time" > timings_dynamic_1.txt

for p in 1 2 4 8 16 24 32
do
    numactl --interleave=all python simulate_dynamic_1.py 100 $p >> timings_dynamic_1.txt
done