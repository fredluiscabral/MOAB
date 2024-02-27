#!/bin/bash
cat saidaPerf.txt | grep 'L1-dcache-load-misses' | awk '{print $1}'
cat saidaPerf.txt | grep 'L1-dcache-load-misses' | awk '{print $1}' | xclip -selection clipboard
