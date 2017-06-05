#!/bin/bash

fold=../dat
data=shots.su
mig=mig_kirchhoff.su
tt=travTime.bin
vel=mod.bin

rayt2d vfile=$fold/$vel tfile=$fold/$tt dt=.004 nt=1000 fz=0 nz=100 dz=25 \
       fx=0 nx=50 dx=25 fzo=0 nzo=100 dz=25 fxo=0 nxo=50 dxo=25 fxs=0 \
       nxs=50 ms=10

sukdmig2d infile=$fold/$data outfile=$fold/$mig ttfile=$fold/$tt \
          fzt=0 nzt=100 dzt=25 fxt=0 nxt=50 dxt=25 fs=0 ns=50 \
          ds=25 dxm=12.5 dzo=5 nzo=605 dxo=25 nxo=50 doff=25      \
          noff=200 fmax=150
