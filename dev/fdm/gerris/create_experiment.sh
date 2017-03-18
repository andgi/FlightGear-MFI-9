#!/bin/bash
# Copyright (C) 2012 - 2017  Anders Gidenstam  (anders(at)gidenstam.org)
# This file is licensed under the GPL license version 2 or later.
#
# Usage: create_experiment.sh <base dir> <name base>

BASEDIR=$1
BASE=$2

# Hydrodynamic reference point [m].
# Relative the origin of the 3d model.
HRPX=0
HRPZ=0

# Water level below the HRP [m].
HAGL=0        # 0ft
#HAGL=0.1524  # 0.5ft
#HAGL=0.3048  # 1.0ft
#HAGL=0.33528 # 1.1ft
#HAGL=0.36576 # 1.2ft
#HAGL=0.39624 # 1.3ft
#HAGL=0.42672 # 1.4ft
#HAGL=0.4572  # 1.5ft
#HAGL=0.48768 # 1.6ft
#HAGL=0.51816 # 1.7ft
#HAGL=0.54864 # 1.8ft
#HAGL=0.57912 # 1.9ft
# floats out of water except at extreme float pitch ~ -7 and +11 deg).
#HAGL=0.6096  # 2.0ft
#HAGL=0.762   # 2.5ft

# Compute actual model offsets.
XOFFSET=`echo -$HRPX | bc`
ZOFFSET=`echo $HAGL-$HRPZ | bc`

#echo $ZOFFSET
#exit

if [ ! -d ${BASEDIR} ]
then
  mkdir ${BASEDIR}
fi
cd ${BASEDIR}

for roll in 0; do
  for pitch in -8 -4 -2 0 2 4 8 12 16; do
    dir=${BASE}_r${roll}_p${pitch}
    mkdir ${dir}
    transform --tx=$XOFFSET --tz=$ZOFFSET < ../float.gts.base | transform --ry ${pitch} | transform --rx ${roll} -v > ${dir}/float.gts

    (cd ${dir}; ln -s ../../buoyancy3D.gfs . )
  done;
done;
