#!/bin/bash

# Script to display the total data usage for the month for wireless interface
# and the data alloted till the day of the month.

wdir=/home/arun/impulse/.sw/netusage
vnstati -i wlp3s0 -m -o $wdir/mstat.png; 
vnstati -i wlp3s0 -d -o $wdir/dstat.png;

# Find data quota:
# 160GB/(days_on_month* 6 person sharing) * current_day_count
alloc=$(cal| awk 'NF {DAYS = $NF}; END {print 160/(DAYS*6)}');
rem=$(date |awk '{print $3*'$alloc'}')

# Annote data quota to the bottom of the image
convert $wdir/mstat.png -gravity SouthEast -annotate 0 $rem  $wdir/mstat.png
display $wdir/mstat.png
