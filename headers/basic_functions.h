#pragma once
#if !defined(_BASIC_FUNCTIONS)
#define _BASIC_FUNCTIONS

namespace __packed_sse_
{

// Packed double-precision floating-point absolute value
extern "C" bool abs_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);
// Packed single-precision floating-point absolute value
extern "C" bool abs_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);
// Packed double-precision floating-point square root
extern "C" bool sqrt_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);
// Packed single-precision floating-point square root
extern "C" bool sqrt_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);
// Packed double-precision floating-point square power
extern "C" bool sqrpow_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);
// Packed single-precision floating-point square power
extern "C" bool sqrpow_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);
// Packed single-precision floating-point minimum values from a pair of aligned memory blocks
extern "C" bool mins_sse_ps(float const *x_aligned_16, float const *y_aligned_16, int n, float *out_aligned_16);
// Packed double-precision floating-point minimum values from a pair of aligned memory blocks
extern "C" bool mins_sse_pd(double const *x_aligned_16, double const *y_aligned_16, int n, double *out_aligned_16);
// Packed single-precision floating-point maximum values from a pair of aligned memory blocks
extern "C" bool maxs_sse_ps(float const *x_aligned_16, float const *y_aligned_16, int n, float *out_aligned_16);
// Packed double-precision floating-point maximum values from a pair of aligned memory blocks
extern "C" bool maxs_sse_pd(double const *x_aligned_16, double const *y_aligned_16, int n, double *out_aligned_16);

} // namespace __packed_sse_

namespace sse_math
{

/**
 * Packed double-precision floating-point absolute value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool abs_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::abs_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point absolute value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool abs_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::abs_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point square root value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sqrt_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::sqrt_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point square root value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sqrt_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::sqrt_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point square power value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sqrpow_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::sqrpow_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point square power value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sqrpow_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::sqrpow_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point minimum values from a pair of aligned memory blocks
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool mins_sse_packed(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::mins_sse_ps(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point minimum values from a pair of aligned memory blocks
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool mins_sse_packed(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::mins_sse_pd(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point maximum values from a pair of aligned memory blocks
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool maxs_sse_packed(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::maxs_sse_ps(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point maximum values from a pair of aligned memory blocks
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool maxs_sse_packed(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::maxs_sse_pd(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

} // namespace sse_math

#endif ///_BASIC_FUNCTIONS
