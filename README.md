Compares Python accelerators Numba, Cython, and f2py to built-in Numpy functions, using for loops or einsum.

To run:

1. Compile `test_f2py.F90` by running `f2py -c -m test_f2py test_f2py.F90`

2. Run the main code using `python test_python_accelerators.py`

Cython code `test_cython.pyx` should be automatically compiled by `pyximport`. 

Performance on Mac OS X 10.10 (Yosemite)
```
In [1]: %run -i test_numba.py
test_numpy: 0.0805640220642
Matches Numpy output: True

test_dumb: 1.43043899536
Matches Numpy output: True

test_numba: 0.464295864105
Matches Numpy output: True

test_cython: 0.627640008926
Matches Numpy output: True

test_f2py: 5.01890516281
Matches Numpy output: True

test_f2py_order: 2.31424307823
Matches Numpy output: True

test_f2py_reorder: 0.507861852646
Matches Numpy output: True
```
