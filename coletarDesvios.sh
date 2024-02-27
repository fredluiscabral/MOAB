#!/bin/bash
cat saidaPerf.txt | grep 'branches' | grep -v 'branch-misses'
cat saidaPerf.txt | grep 'branches' | grep -v 'branch-misses' | awk '{print $1}' | xclip -selection clipboard
