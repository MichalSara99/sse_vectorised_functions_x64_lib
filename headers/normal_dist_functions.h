#pragma once
#if !defined(_NORMAL_DIST_FUNCTIONS)
#define _NORMAL_DIST_FUNCTIONS

namespace __packed_sse_
{

// Packed single-precision floating-point normal CDF
extern "C" bool norm_cdf_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);

// Packed double-precision floating-point normal CDF
extern "C" bool norm_cdf_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);

// Packed single-precision floating-point normal PDF
extern "C" bool norm_pdf_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);

// Packed double-precision floating-point normal PDF
extern "C" bool norm_pdf_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);

// Packed single-precision floating-point inverse normal CDF
extern "C" bool norm_inv_cdf_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);

// Packed double-precision floating-point inverse normal CDF
extern "C" bool norm_inv_cdf_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);

} // namespace __packed_sse_

namespace sse_math
{

/**
 * Packed single-precision floating-point normal CDF
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool norm_cdf_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::norm_cdf_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point normal CDF
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool norm_cdf_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::norm_cdf_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point normal PDF
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool norm_pdf_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::norm_pdf_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point normal PDF
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool norm_pdf_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::norm_pdf_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point inverse normal CDF
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool norm_inv_cdf_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::norm_inv_cdf_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point inverse normal CDF
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool norm_inv_cdf_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::norm_inv_cdf_sse_pd(in_aligned_16, size, out_aligned_16);
}

} // namespace sse_math

#endif ///_NORMAL_DIST_FUNCTIONS
