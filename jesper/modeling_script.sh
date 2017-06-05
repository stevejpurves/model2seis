#!/bin/bash
#This script models shots for the Marmousi data set using sufdmod2.
#It has to be looped becuase the algorithm only models one shot
#at a time. 

STARTTIME=$(date +%s)
fold=/mnt/y/Hackathon/model2seis/jesper

delx=25
delz=25
numShot=30
dShot=2
out=output

rm $fold/$out*

foo () {
	shotx=$(($1*$dShot*$delx))
	shotz=$((1*$delz))
	echo -e "\nShot number $index1 at x location: $shotx meters"
	sufdmod2 <$fold/test.bin > /dev/null nx=500 nz=250 xs=$shotx zs=$shotz \
		 tmax=4 hsz=15 hsfile=$fold/hsfile$1.su abs=0,1,1,1 verbose=0 dx=$delx \
		 dz=$delz fmax=150
	sushw < $fold/hsfile$1.su a=$1 key=ep >> $fold/$out$1
	rm hsfile$1.su
}

for index1 in $(seq 1 $numShot);do foo "$index1" & done

wait $(jobs -p)

echo "Preparing output."
fcat $fold/$out* > $fold/$out
susort ep offset < $fold/$out |
sushw key=tracl a=1 b=1 > $fold/shots.su

rm $fold/$out*

ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task..."

