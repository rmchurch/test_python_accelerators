#/usr/bin python
import numpy as np
cimport numpy as np

def test_cython(np.ndarray[np.float64_t,ndim=4] f, np.ndarray[np.float64_t,ndim=2] b):
	# cdef np.ndarray[np.float64_t,ndim=4] f
	# cdef np.ndarray[np.float64_t,ndim=2] b
	cdef np.ndarray[np.float64_t,ndim=2] fnew = np.empty((f.shape[1],f.shape[2]),dtype=np.float64)
	cdef int i,j,k,l
	cdef int Ni = f.shape[0]
	cdef int Nj = f.shape[1]
	cdef int Nk = f.shape[2]
	cdef int Nl = f.shape[3]
	
	for i in range(Ni):
		for j in range(Nj):
			for k in range(Nk):
				for l in range(Nl):
					fnew[j,k] += f[i,j,k,l] * b[i,l]
	return fnew