#!/bin/bash

a2b < twoVelHeteroStripe10percent.dat outpar=a2b.log n1=50 > temp.bin
transp < temp.bin n1=50 > mod.bin

rm temp.bin


ximage < mod.bin n1=100
