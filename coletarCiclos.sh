#!/bin/bash
cat saidaPerf.txt | grep 'cycles'
cat saidaPerf.txt | grep 'cycles' | awk '{print $1}' | xclip -selection clipboard
