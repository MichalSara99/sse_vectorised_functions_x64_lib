#pragma once
#if !defined(_SSE_UTILITIES)
#define _SSE_UTILITIES

#include <new>
#include <typeinfo>

namespace sse_utilities
{

template <typename Type> Type *aligned_alloc(std::size_t size, std::size_t Alignment)
{
    return (Type *)operator new[](sizeof(Type) * size, std::align_val_t(Alignment));
}

template <typename Type> void aligned_free(Type *x)
{
    _aligned_free((void *)x);
}

} // namespace sse_utilities

#endif ///_SSE_UTILITIES
