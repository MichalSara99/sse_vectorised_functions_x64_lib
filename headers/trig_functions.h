#pragma once
#if !defined(_TRIG_FUNCTIONS)
#define _TRIG_FUNCTIONS

namespace __packed_sse_
{
// packed double-precision floating-point cosine
extern "C" bool cos_sse_pd(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point cosine
extern "C" bool cos_sse_ps(float const *in_aligned_16, int n4, float *out_aligned_16);

// packed double-precision floating-point sine
extern "C" bool sin_sse_pd(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point sine
extern "C" bool sin_sse_ps(float const *in_aligned_16, int n4, float *out_aligned_16);

// packed single-precision floating-point tangens
extern "C" bool tan_sse_ps(float const *in_aligned_16, int n4, float *out_aligned_16);

// packed single-precision floating-point cotangens
extern "C" bool cot_sse_ps(float const *in_aligned_16, int n4, float *out_aligned_16);

} // namespace __packed_sse_

namespace sse_math
{

/**
 * Packed double-precision floating-point cosine
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool cos_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::cos_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point cosine
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool cos_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::cos_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point sine
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sin_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::sin_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point sine
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sin_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::sin_sse_ps(in_aligned_16, size, out_aligned_16);
}
// packed single-precision floating-point tangens
bool tan_sse_packed(float const *in_aligned_16, int size4, float *out_aligned_16)
{
    return __packed_sse_::tan_sse_ps(in_aligned_16, size4, out_aligned_16);
}
// packed single-precision floating-point cotangens
bool cot_sse_packed(float const *in_aligned_16, int size4, float *out_aligned_16)
{
    return __packed_sse_::cot_sse_ps(in_aligned_16, size4, out_aligned_16);
}

} // namespace sse_math

#endif ///_TRIG_FUNCTIONS
