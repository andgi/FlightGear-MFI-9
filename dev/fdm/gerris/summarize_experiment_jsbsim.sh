#!/bin/bash
# Copyright (C) 2012 - 2017  Anders Gidenstam  (anders(at)gidenstam.org)
# This file is licensed under the GPL license version 2 or later.
#
# Usage: summarize_experiment.sh <base dir>


BASE=$1

# Note: We are only interested in 
#  z force and pitch and roll moment.
#  Output formatted as JSBSim tables with pitch angle
#  as row and roll angle as column index.
#
#  The resulting "coefficients" are scaled for imperial units
#  and expressed as
#    F/(Rho*G) and M/(Rho*G)

echo "Z Force (hagl, pitch)"
echo "   -8.0   -4.0   -2.0   0.0   2.0   4.0   8.0   12.0   16.0"
for hagl in 0 0.5 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.5; do
  ROW=${hagl}
  for pitch in -8 -4 -2 0 2 4 8 12 16; do
    roll=0
    dir=${BASE}/p${hagl}ft_r${roll}_p${pitch}
    ROW=${ROW}`awk 'BEGIN {
            U = 8.0*3.2808399; Rho = 1.0; G = 1.0;
            k_F = U^3 * Rho * G;
          }
          /[0-9]*\.0/ { print "   " k_F*$4; exit; }' ${dir}/f`
  done;
  echo ${ROW}
done;
echo;

echo "Y Moment (hagl, pitch) (~pitch moment)"
echo "   -8.0   -4.0   -2.0   0.0   2.0   4.0   8.0   12.0   16.0"
for hagl in 0 0.5 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.5; do
  ROW=${hagl}
  for pitch in -8 -4 -2 0 2 4 8 12 16; do
    roll=0
    dir=${BASE}/p${hagl}ft_r${roll}_p${pitch}
    ROW=${ROW}`awk 'BEGIN {
             U = 8.0*3.2808399; Rho = 1.0; G = 1.0;
             k_M = U^4 * Rho * G;
           }
           /[0-9]*\.0/ { print "   " k_M*$9; exit; }' ${dir}/f`
  done
  echo ${ROW}
done;
echo;

exit

echo "X Moment (pitch, roll) (~roll moment)"
echo "   0.0"
for pitch in -8 -4 -2 0 2 4 8 12 16; do
  ROW=${pitch}
  for roll in 0; do
    dir=${BASE}_r${roll}_p${pitch}
    ROW=${ROW}`awk 'BEGIN {
             U = 10.0*3.2808399; Rho = 1.0; G = 1.0;
             k_M = U^4 * Rho * G;
           }
           /[0-9]*\.0/ { print "   " k_M*$8; exit; }' ${dir}/f`
  done
  echo ${ROW}
done;
echo;
