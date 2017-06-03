import string
import sys
import struct
import numpy as np
import math

# convert floating point to ibm
def ieee2ibm(x, endian):
	# check input data
	if(x > 7.236998675585915e+75):
		return(0x7ffffff0)

	if(x < -7.236998675585915e+75):
		return(0xfffffff0)

	if(x == 0):
		return 0

	if(x == np.NAN):  #check input if NAN number
		return (0x7fffffff)

	#conversion log2 from matlab
	F, E = math.frexp(abs(x))

	e = float (E/4.0);              # exponent of base 16
	ec = math.ceil(e);            # adjust upwards to integer
	p = ec + 64;                  # offset exponent

	f = F * pow(2,(-4*(ec-e)));   #  correct mantissa for fractional part of exponent
	# convert to integer. Roundoff here can be as large as
	# 0.5/2^20 when mantissa is close to 1/16 so that
	# 3 bits of signifance are lost.
	f1 = round(f * 0x1000000);

	# format hex
	# put exponent in first byte of psi.
	tmpi = p * 0x1000000;
	if(tmpi<=0):
		psi = 0
	elif(tmpi>=0xFFFFFFFF):
		psi = 0xFFFFFFFF
	else:
		psi = tmpi

	# put mantissa into last 3 bytes of phi
	if(f1<=0):
		phi = 0
	elif(f1>=0xFFFFFFFF):
		phi = 0xFFFFFFFF
	else:
		phi = f1

	# make bit representation
	# exponent and mantissa
	b = int(psi) | int(phi)
	# sign bit
	if(x<0):
		b = b + 0x80000000

	#print b
	b = np.uint32(b)
	if(endian):      #big endian
		cval = struct.pack(">i",b)
	else:            #litte endian
		cval = struct.pack("<i",b)

	return (cval)
