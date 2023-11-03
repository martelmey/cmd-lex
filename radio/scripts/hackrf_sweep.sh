#!/bin/bash
# Based on:
# https://www.rtl-sdr.com/scanning-spectrum-8ghz-per-second-new-hackrf-update/
# Heatmap:
# https://github.com/keenerd/rtl-sdr-misc

hackrf_sweep -f1:3000 -w100000 -l32 -g8 > output_data.csv
cd /home/mxana/radio/rtl-sdr-misc/heatmap
cp ~/radio/output_data.csv .
python3 heatmap.py output_data.csv heatmap_image.png