#pragma once
#if !defined(_EXP_FUNCTIONS)
#define _EXP_FUNCTIONS

namespace __packed_sse_
{
// Packed fast single-precision floating-point exp
extern "C" bool exp_fast_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);

// Packed fast double-precision floating-point exp
extern "C" bool exp_fast_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);

// Packed single-precision floating-point exp
extern "C" bool exp_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);

// Packed double-precision floating-point exp
extern "C" bool exp_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);

} // namespace __packed_sse_

namespace sse_math
{

/**
 * Packed fast double-precision floating-point exponential function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool exp_fast_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::exp_fast_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed fast single-precision floating-point exponential function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool exp_fast_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::exp_fast_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point exponential function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool exp_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::exp_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed fast single-precision floating-point exponential function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool exp_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::exp_sse_ps(in_aligned_16, size, out_aligned_16);
}

} // namespace sse_math

#endif ///_EXP_FUNCTIONS
