#!/bin/bash

fold=../dat
data=shots.su
mig=mig_kirchhoff.su
tt=travTime.bin
vel=simple.bin

rayt2d vfile=$fold/$vel tfile=$fold/$tt dt=.004 nt=4000 fz=0 nz=250 dz=25 \
       fx=0 nx=500 dx=25 fxs=0 nxs=500 dxs=25 ms=1

sukdmig2d infile=$fold/$data outfile=$fold/$mig ttfile=$fold/$tt \
          fzt=0 nzt=250 dzt=25 fxt=0 nxt=500 dxt=25 fs=0 ns=500 \
          ds=25 dzo=5 nzo=1245 dxo=25 nxo=500 ntr=250000
