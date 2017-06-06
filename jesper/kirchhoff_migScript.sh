#!/bin/bash

fold=.
data=shots.su
mig=mig_kirchhoff.su
tt=travTime.bin
vel=test.bin
STARTTIME=$(date +%s)
rayt2d vfile=$fold/$vel tfile=$fold/$tt dt=.004 nt=1000 fz=0 nz=250 dz=25 \
       fx=0 nx=500 dx=25 dz=25 fxs=0 nxs=35 ms=10

sukdmig2d infile=$fold/$data outfile=$fold/$mig ttfile=$fold/$tt \
          fzt=0 nzt=250 dzt=25 fxt=0 nxt=500 dxt=25 fs=0 ns=35 \
          ds=25 dxm=12.5 dzo=5 nzo=605 dxo=25 nxo=50 doff=25      \
          noff=200 fmax=250

#sustack < $fold/$mig key=cdp > stack.su
ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to migrate the data."
