#!/bin/bash

fold=.

suazimuth < $fold/shots.su cmp=1 mxkey=gwdep |
suchw key1=cdp key2=gwdep > $fold/temp.su
susort cdp offset < $fold/temp.su > $fold/cdp_sort.su 

sunmo < $fold/cdp_sort.su > $fold/nmo.su par=$fold/test.bin

rm $fold/temp.su
