#!/bin/bash

fold=/home/graham/diss

suazimuth < $fold/shots.su cmp=1 mxkey=gwdep |
suchw key1=cdp key2=gwdep > $fold/temp.su
susort < $fold/temp.su > $fold/cdp_sort.su cdp offset

sunmo < $fold/cdp_sort.su > $fold/nmo.su par=$fold/nmo_par

rm $fold/temp.su
