# SSE Vectorised Functions 64-bit library
DLL library consisting of vectorised math functions written in Assembly x86-64 and calling in C++.

## List
* sin, cos (SPFP,DPFP)
* tan, cot (SPFP)
* exp_fast (SPFP,DPFP)
* exp (SPFP,DPFP)
* natural log (SPFP,DPFP)
* erf,erfc (SPFP,DPFP)
* add,sub,mul,div,neg,inv (SPFP,DPFP)
* abs,sqrt,sqrpow,mins,maxs (SPFP,DPFP)
* normal CDF (SPFP,DPFP)
* normal PDF (SPFP,DPFP)
* normal inverse CDF (SPFP,DPFP)

** SPFP = single-precision floating-point, DPFP = double-precision floating-point

## Usage
Include sse_vectorised_functions_x64_lib.dll in your project and include <sse_math_x64_lib.h> header file.
See repo sse_vectorised_functions_x64_tests, for example.


