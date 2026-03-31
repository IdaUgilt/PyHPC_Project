#!/bin/bash
#BSUB -J timer                          # Job name
#BSUB -q hpc                                # Queue name
#BSUB -W 10                                 # Wall-clock time
#BSUB -R "rusage[mem=2GB]"                  # Resources
#BSUB -o Timer=5_%J.out                 # Output file (stdout)
#BSUB -e Timer=5_%J.err                 # Output file (stderr)
#BSUB -R "select[model==XeonGold6226R]"     # Select CPU model
#BSUB -n 1                                  # Select number of cores
#BSUB -R "span[hosts=1]"                    # Specify that the number of cores must be on the same host

# InitializePythonenvironment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613

# Run Python script
echo "10"
Time simulate.py 10

echo "13"
Time simulate.py 13

echo "16"
Time simulate.py 16


echo "20"
Time simulate.py 20