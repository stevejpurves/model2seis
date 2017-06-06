#!/bin/bash
#This script models shots for the Marmousi data set using sufdmod2.
#It has to be looped becuase the algorithm only models one shot
#at a time. 

STARTTIME=$(date +%s)
fold=/mnt/y/Hackathon/model2seis/jesper

delx=15
delz=25
numShot=35
dShot=1
out=output

#ibm2float < simple.su > simpleswap.su
#transp n1=500 < simpleswap.su > test.bin

rm $fold/$out*

foo () {
	shotx=$(($1*$dShot*$delx))
	shotz=$((1*$delz))
	echo -e "\nShot number $index1 at x location: $shotx meters"
	sufdmod2_pml <$fold/test.bin > /dev/null nx=500 nz=250 xs=$shotx zs=$shotz \
		 tmax=2 hsz=15 hsfile=$fold/hsfile$1.su abs=0,1,1,1 verbose=0 dx=$delx \
		 dz=$delz fmax=250
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

