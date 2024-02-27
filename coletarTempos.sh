#!/bin/bash
cat saidaPerf.txt | grep ';' # awk '{print $3}'
cat saidaPerf.txt | grep ';' | xclip -selection clipboard
