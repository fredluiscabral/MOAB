#!/bin/bash
cat saidaPerf.txt | grep 'LLC-load-misses' | awk '{print $1}'
cat saidaPerf.txt | grep 'LLC-load-misses' | awk '{print $1}' | xclip -selection clipboard
