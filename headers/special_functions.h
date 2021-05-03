#pragma once
#if !defined(_SPECIAL_FUNCTIONS)
#define _SPECIAL_FUNCTIONS

namespace __packed_sse_
{
// Packed double-precision floating-point error function
extern "C" bool erf_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);
// Packed single-precision floating-point error function
extern "C" bool erf_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);

// Packed double-precision floating-point complementary error function
extern "C" bool erfc_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);
// Packed single-precision floating-point complementary error function
extern "C" bool erfc_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);
} // namespace __packed_sse_

namespace sse_math
{

/**
 * Packed double-precision floating-point error function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool erf_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::erf_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point error function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool erf_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::erf_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point complementary error function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool erfc_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::erfc_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point complementary error function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool erfc_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::erfc_sse_ps(in_aligned_16, size, out_aligned_16);
}

} // namespace sse_math

#endif ///_SPECIAL_FUNCTIONS
