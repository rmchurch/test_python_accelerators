#/usr/bin python

import numpy as np
import numba
from numba import vectorize, float64
import time
import test_f2py as tf2py
import pyximport
pyximport.install(setup_args={'include_dirs':np.get_include()})
import test_cython as tcyth

def test_dumb(f,b):
	fnew = np.empty((f.shape[1],f.shape[2]))
	for i in range(f.shape[0]):
		for l in range(f.shape[3]):
			fnew += f[i,:,:,l] * b[i,l]
	return fnew


def test_dumber(f,b):
	fnew = np.empty((f.shape[1],f.shape[2]))
	for i in range(f.shape[0]):
		for j in range(f.shape[1]):
			for k in range(f.shape[2]):
				for l in range(f.shape[3]):
					fnew[j,k] += f[i,j,k,l] * b[i,l]
	return fnew

@numba.jit(nopython=True)
def test_numba(f,b):
	fnew = np.zeros((f.shape[1],f.shape[2])) #NOTE: can't be empty, gives errors
	for i in range(f.shape[0]):
		for j in range(f.shape[1]):
			for k in range(f.shape[2]):
				for l in range(f.shape[3]):
					fnew[j,k] += f[i,j,k,l] * b[i,l]
	return fnew

def test_numpy(f,b):
	return np.einsum('i...k,ik->...',f,b)

def test_f2py(f,b):
	return tf2py.test_f2py(f,b)

def test_f2py_order(f,b):
	return tf2py.test_f2py(f,b)

def test_f2py_reorder(f,b):
	return tf2py.test_f2py_reorder(f,b)

def test_cython(f,b):
	return tcyth.test_cython(f,b)

if __name__ == '__main__':
	
	#goal is to create: fnew = sum f*b over dim 0 and 3.
	f = np.random.rand(32,33,2000,64)
	b = np.random.rand(32,64)

	f1 = np.asfortranarray(f)
	b1 = np.asfortranarray(b)

	f2 = np.asfortranarray(np.transpose(f,[1,2,0,3]))

	funcs = [test_dumb,test_numba, test_cython, \
			test_f2py,test_f2py_order,test_f2py_reorder]

	tstart = time.time()	
	fnew_numpy= test_numpy(f,b)
	tstop = time.time()
	print test_numpy.__name__+': '+str(tstop-tstart)
	print 'Matches Numpy output: '+str(np.allclose(fnew_numpy,fnew_numpy))
	print ''

	for func in funcs:
		tstart = time.time()
		if func.__name__ == 'test_f2py_order':
			fnew = func(f1,b1)
		elif func.__name__ == 'test_f2py_reorder':
			fnew = func(f2,b1)
		else:
			fnew = func(f,b)
		tstop = time.time()
		print func.__name__+': '+str(tstop-tstart)
		print 'Matches Numpy output: '+str(np.allclose(fnew,fnew_numpy))
		print ''
