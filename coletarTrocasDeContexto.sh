#!/bin/bash
cat saidaPerf.txt | grep 'context-switches' | awk '{print $1}'
cat saidaPerf.txt | grep 'context-switches' | awk '{print $1}' | xclip -selection clipboard
