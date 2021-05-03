#pragma once
#if !defined(_LOG_FUNCTIONS)
#define _LOG_FUNCTIONS

namespace __packed_sse_
{

// Packed single-precision floating-point natural log
extern "C" bool log_sse_ps(float const *in_aligned_16, int n, float *out_aligned_16);
// Packed double-precision floating-point natural log
extern "C" bool log_sse_pd(double const *in_aligned_16, int n, double *out_aligned_16);

} // namespace __packed_sse_

namespace sse_math
{

/**
 * Packed single-precision floating-point natural log function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool log_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::log_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point natural log function
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool log_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::log_sse_pd(in_aligned_16, size, out_aligned_16);
}

} // namespace sse_math

#endif ///_LOG_FUNCTIONS
