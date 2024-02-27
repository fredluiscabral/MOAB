#!/bin/bash

source /opt/intel/oneapi/setvars.sh 

# Lista de análises
#ANALISES=(
#    'vtune -collect performance-snapshot'
#    'perf stat'
#    'perf stat -e context-switches'
#    'perf stat -e LLC-load-misses'
#    'perf stat -e L1-dcache-load-misses'
#    'perf stat -e l2_rqsts.miss'
#)

ANALISES=(
#    'vtune -collect performance-snapshot'
    'perf stat -e L1-dcache-loads,L1-dcache-load-misses,L2-loads,L2-load-misses,LLC-loads,LLC-load-misses,instructions,cycles,branches,branch-misses'
)    

# Executável e parâmetro
EXEC='/prj/prjad/fcabral/Doutorado/MOAB/MultMatEWS_Estatico'
PARAM=10000

# Iteração sobre diferentes análises
for ANALISE in "${ANALISES[@]}"
do
    # output_file="saida_${ANALISE// /_}.txt"  # Remove espaços para nome do arquivo

    output_file="saidaPerf.txt"

    # Certifique-se de que o arquivo de saída esteja vazio no início
    > "$output_file"

    # Iteração sobre diferentes números de threads
    for nt in {1..16} {24..10000..80}
    do
        export OMP_NUM_THREADS=${nt}
        # Redireciona stderr para stdout e usa tee para escrever em arquivo em modo de anexação
        eval $ANALISE $EXEC $PARAM 2>&1 | tee -a "$output_file"
    done
done

