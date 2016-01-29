Compares Python accelerators Numba, Cython, and f2py to built-in Numpy functions, using for loops or einsum.

To run:
1. Compile test_f2py.F90 by running 'f2py -c -m test_f2py test_f2py.F90'
2. Run the main code using 'python test_python_accelerators.py'

Cython code test_cython.pyx should be automatically compiled by pyximport. 
