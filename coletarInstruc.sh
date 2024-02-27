#!/bin/bash
cat saidaPerf.txt | grep 'instructions'
cat saidaPerf.txt | grep 'instructions' | awk '{print $1}' | xclip -selection clipboard
