#!/bin/bash
cat saidaPerf.txt | grep 'L2-load-misses' | awk '{print $1}'
cat saidaPerf.txt | grep 'L2-load-misses' | awk '{print $1}' | xclip -selection clipboard
