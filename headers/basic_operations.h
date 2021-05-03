#pragma once
#if !defined(_BASIC_OPERATIONS)
#define _BASIC_OPERATIONS

//#include "sse_macros.h"

namespace __packed_sse_
{
// packed double-precision floating-point broadcast multiplication
extern "C" bool mul_br_sse_pd(double const *x_aligned_16, double const y, int n2, double *out_aligned_16);
// packed single-precision floating-point broadcast multiplication
extern "C" bool mul_br_sse_ps(float const *x_aligned_16, float const y, int n4, float *out_aligned_16);
// packed double-precision floating-point multiplication
extern "C" bool mul_sse_pd(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point multiplication
extern "C" bool mul_sse_ps(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point broadcast division
extern "C" bool div_br_sse_pd(double const *x_aligned_16, double const y, int n2, double *out_aligned_16);
// packed single-precision floating-point broadcast division
extern "C" bool div_br_sse_ps(float const *x_aligned_16, float const y, int n4, float *out_aligned_16);
// packed double-precision floating-point broadcast division
extern "C" bool div_br_s_sse_pd(double const x, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point broadcast division
extern "C" bool div_br_s_sse_ps(float const x, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point division
extern "C" bool div_sse_pd(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point division
extern "C" bool div_sse_ps(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point broadcast addition
extern "C" bool add_br_sse_pd(double const *x_aligned_16, double const y, int n2, double *out_aligned_16);
// packed single-precision floating-point broadcast addition
extern "C" bool add_br_sse_ps(float const *x_aligned_16, float const y, int n4, float *out_aligned_16);
// packed double-precision floating-point addition
extern "C" bool add_sse_pd(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point addition
extern "C" bool add_sse_ps(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point broadcast subtraction
extern "C" bool sub_br_sse_pd(double const *x_aligned_16, double const y, int n2, double *out_aligned_16);
// packed single-precision floating-point broadcast subtraction
extern "C" bool sub_br_sse_ps(float const *x_aligned_16, float const y, int n4, float *out_aligned_16);
// packed double-precision floating-point broadcast subtraction
extern "C" bool sub_br_s_sse_pd(double const x, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point broadcast subtraction
extern "C" bool sub_br_s_sse_ps(float const x, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point subtraction
extern "C" bool sub_sse_pd(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point subtraction
extern "C" bool sub_sse_ps(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point negative value
extern "C" bool neg_sse_pd(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point negative value
extern "C" bool neg_sse_ps(float const *in_aligned_16, int n2, float *out_aligned_16);
// packed double-precision floating-point inverse(=inverted) value
extern "C" bool inv_sse_pd(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point inverse(=inverted) value
extern "C" bool inv_sse_ps(float const *in_aligned_16, int n2, float *out_aligned_16);
} // namespace __packed_sse_

namespace sse_math
{

/**
 * Packed double-precision floating-point broadcast multiplication
 *
 * \param x_aligned_16
 * \param y
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool mul_br_sse_packed(double const *x_aligned_16, double const y, int size, double *out_aligned_16)
{
    return __packed_sse_::mul_br_sse_pd(x_aligned_16, y, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point broadcast multiplication
 *
 * \param x_aligned_16
 * \param y
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool mul_br_sse_packed(float const *x_aligned_16, float const y, int size, float *out_aligned_16)
{
    return __packed_sse_::mul_br_sse_ps(x_aligned_16, y, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point multiplication
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool mul_sse_packed(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::mul_sse_pd(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point multiplication
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool mul_sse_packed(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::mul_sse_ps(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point broadcast division
 *
 * \param x_aligned_16
 * \param y
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool div_br_sse_packed(double const *x_aligned_16, double const y, int size, double *out_aligned_16)
{
    return __packed_sse_::div_br_sse_pd(x_aligned_16, y, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point broadcast division
 *
 * \param x_aligned_16
 * \param y
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool div_br_sse_packed(float const *x_aligned_16, float const y, int size, float *out_aligned_16)
{
    return __packed_sse_::div_br_sse_ps(x_aligned_16, y, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point broadcast division
 *
 * \param x
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool div_br_s_sse_packed(double const x, double const *y_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::div_br_s_sse_pd(x, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point broadcast division
 *
 * \param x
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool div_br_s_sse_packed(float const x, float const *y_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::div_br_s_sse_ps(x, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point division
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool div_sse_packed(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::div_sse_pd(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point division
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool div_sse_packed(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::div_sse_ps(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point broadcast addition
 *
 * \param x_aligned_16
 * \param y
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool add_br_sse_packed(double const *x_aligned_16, double const y, int size, double *out_aligned_16)
{
    return __packed_sse_::add_br_sse_pd(x_aligned_16, y, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point broadcast addition
 *
 * \param x_aligned_16
 * \param y
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool add_br_sse_packed(float const *x_aligned_16, float const y, int size, float *out_aligned_16)
{
    return __packed_sse_::add_br_sse_ps(x_aligned_16, y, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point addition
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool add_sse_packed(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::add_sse_pd(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point addition
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool add_sse_packed(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::add_sse_ps(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point broadcast subtraction
 *
 * \param x_aligned_16
 * \param y
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sub_br_sse_packed(double const *x_aligned_16, double const y, int size, double *out_aligned_16)
{
    return __packed_sse_::sub_br_sse_pd(x_aligned_16, y, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point broadcast subtraction
 *
 * \param x_aligned_16
 * \param y
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sub_br_sse_packed(float const *x_aligned_16, float const y, int size, float *out_aligned_16)
{
    return __packed_sse_::sub_br_sse_ps(x_aligned_16, y, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point broadcast subtraction
 *
 * \param x
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sub_br_s_sse_packed(double const x, double const *y_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::sub_br_s_sse_pd(x, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point broadcast subtraction
 *
 * \param x
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sub_br_s_sse_packed(float const x, float const *y_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::sub_br_s_sse_ps(x, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point subtraction
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sub_sse_packed(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::sub_sse_pd(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point subtraction
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool sub_sse_packed(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::sub_sse_ps(x_aligned_16, y_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point negative value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool neg_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::neg_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point negative value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool neg_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::neg_sse_ps(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed double-precision floating-point inverse value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool inv_sse_packed(double const *in_aligned_16, int size, double *out_aligned_16)
{
    return __packed_sse_::inv_sse_pd(in_aligned_16, size, out_aligned_16);
}

/**
 * Packed single-precision floating-point inverse value
 *
 * \param in_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
bool inv_sse_packed(float const *in_aligned_16, int size, float *out_aligned_16)
{
    return __packed_sse_::inv_sse_ps(in_aligned_16, size, out_aligned_16);
}

} // namespace sse_math

#endif ///_BASIC_OPERATIONS
