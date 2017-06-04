#!/bin/bash

#This script models shots using sufdmod2.
#It has to be looped becuase the algorithm only models one shot
#at a time. 

fold=.
delx=25
delz=25
numShot=50
dShot=1
out=output.su

rm $fold/$out

for (( index1=1; index1<=$numShot; index1++ ))
	do
	shotx=$(($index1*$dShot*$delx))
	shotz=$((1*$delz))
	echo -e "\nShot number $index1 at x location: $shotx meters"
	sufdmod2 <$fold/mod.bin >$fold/temp.su nx=50 nz=100 xs=$shotx zs=$shotz \
		 tmax=4 hsz=15 hsfile=$fold/$index1.su abs=0,1,1,1 verbose=1 dx=$delx \
		 dz=$delz fmax=150
	cat $fold/$index1.su >> $fold/$out
	rm $fold/$index1.su
	done

sushw < $fold/$out a=1 b=0 c=1 j=50 key=ep |
sushw key=tracl a=1 b=1 > $fold/shots.su

rm $fold/$out
rm $fold/temp.su
