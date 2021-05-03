.const
align 16
;; ======================================= packed single precision floating point for TAN,COT =========================================

cephes_fopi_ps					real4	1.27323954473516,1.27323954473516,1.27323954473516,1.27323954473516

cephes_dp_ps					real4	-0.78515625,-0.78515625,-0.78515625,-0.78515625
								real4	-2.4187564849853515625e-4,-2.4187564849853515625e-4,-2.4187564849853515625e-4,-2.4187564849853515625e-4
								real4	-3.77489497744594108e-8,-3.77489497744594108e-8,-3.77489497744594108e-8,-3.77489497744594108e-8

tancof_ps						real4	9.38540185543e-3,9.38540185543e-3,9.38540185543e-3,9.38540185543e-3
								real4	3.11992232697e-3,3.11992232697e-3,3.11992232697e-3,3.11992232697e-3
								real4	2.44301354525e-2,2.44301354525e-2,2.44301354525e-2,2.44301354525e-2
								real4	5.34112807005e-2,5.34112807005e-2,5.34112807005e-2,5.34112807005e-2
								real4	1.33387994085e-1,1.33387994085e-1,1.33387994085e-1,1.33387994085e-1
								real4	3.33331568548e-1,3.33331568548e-1,3.33331568548e-1,3.33331568548e-1

one_ps							real4	1.0,1.0,1.0,1.0
;; =========================================================== GENERAL ===========================================================

int_sign_mask_d					dword	80000000h,80000000h,80000000h,80000000h
int_inv_sign_mask_d				dword	7fffffffh,7fffffffh,7fffffffh,7fffffffh
int_one_d						dword	1h,1h,1h,1h
int_inv_one_d					dword	-2,-2,-2,-2
int_two_d						dword	2h,2h,2h,2h


								.code

;;				extern "C" bool tan_sse_ps(float const* x, int n, float* out);
;;													rcx,	rdx,			r8
tan_sse_ps						proc uses rbx

								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz Done

								test r8,0fh
								jnz Done

								mov rcx,rdx
								cmp rcx,4
								jl Done

								and rcx,0fffffffeh

				  @@:			movaps xmm0,xmmword ptr [rbx]					;; x = xmm0
								movaps xmm1,xmm0								;; sign_bit = xmm1
								andps xmm0,xmmword ptr [int_inv_sign_mask_d]	
								andps xmm1,xmmword ptr [int_sign_mask_d]
								movaps xmm2,xmm0
								mulps xmm2,xmmword ptr [cephes_fopi_ps]			;; y = xmm2

								cvttps2dq xmm3,xmm2								
								paddd xmm3,xmmword ptr [int_one_d]
								pand xmm3,xmmword ptr [int_inv_one_d]
								cvtdq2ps xmm2,xmm3
								pand xmm3,xmmword ptr [int_two_d]
								pxor xmm7,xmm7
								pcmpeqd xmm3,xmm7								;; poly_msk = xmm3

								movaps xmm4,xmmword ptr [cephes_dp_ps]
								movaps xmm5,xmmword ptr [cephes_dp_ps + 16]
								movaps xmm6,xmmword ptr [cephes_dp_ps + 32]

								mulps xmm4,xmm2
								mulps xmm5,xmm2
								mulps xmm6,xmm2

								addps xmm0,xmm4									;; z = xmm0
								addps xmm0,xmm5
								addps xmm0,xmm6

								movaps xmm7,xmm0								
								mulps xmm7,xmm7									;; zz = xmm7

								movaps xmm2,xmmword ptr [tancof_ps]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 16]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 32]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 48]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 64]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 80]
								mulps xmm2,xmm7
								mulps xmm2,xmm0
								addps xmm2,xmm0

								movaps xmm4,xmmword ptr [one_ps]
								divps xmm4,xmm2
								xorps xmm4,xmmword ptr [int_sign_mask_d]

								andps xmm2,xmm3
								andnps xmm3,xmm4
								orps xmm2,xmm3
								xorps xmm2,xmm1
	
								movaps xmmword ptr [r8],xmm2
								add rbx,16
								add r8,16
								sub rcx,4
								jnz @B

								mov rax,1

				Done:			ret
tan_sse_ps						endp

;;				extern "C" bool cot_sse_ps(float const* x, int n, float* out);
;;													rcx,	rdx,		r8
cot_sse_ps						proc uses rbx

								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz Done

								test r8,0fh
								jnz Done

								mov rcx,rdx
								cmp rcx,4
								jl Done

								and rcx,0fffffffeh

				  @@:			movaps xmm0,xmmword ptr [rbx]					;; x = xmm0
								movaps xmm1,xmm0								;; sign_bit = xmm1
								andps xmm0,xmmword ptr [int_inv_sign_mask_d]	
								andps xmm1,xmmword ptr [int_sign_mask_d]
								movaps xmm2,xmm0
								mulps xmm2,xmmword ptr [cephes_fopi_ps]			;; y = xmm2

								cvttps2dq xmm3,xmm2								
								paddd xmm3,xmmword ptr [int_one_d]
								pand xmm3,xmmword ptr [int_inv_one_d]
								cvtdq2ps xmm2,xmm3
								pand xmm3,xmmword ptr [int_two_d]
								pxor xmm7,xmm7
								pcmpeqd xmm3,xmm7								;; poly_msk = xmm3

								movaps xmm4,xmmword ptr [cephes_dp_ps]
								movaps xmm5,xmmword ptr [cephes_dp_ps + 16]
								movaps xmm6,xmmword ptr [cephes_dp_ps + 32]

								mulps xmm4,xmm2
								mulps xmm5,xmm2
								mulps xmm6,xmm2

								addps xmm0,xmm4									;; z = xmm0
								addps xmm0,xmm5
								addps xmm0,xmm6

								movaps xmm7,xmm0								
								mulps xmm7,xmm7									;; zz = xmm7

								movaps xmm2,xmmword ptr [tancof_ps]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 16]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 32]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 48]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 64]
								mulps xmm2,xmm7
								addps xmm2,xmmword ptr [tancof_ps + 80]
								mulps xmm2,xmm7
								mulps xmm2,xmm0
								addps xmm2,xmm0

								movaps xmm4,xmmword ptr [int_sign_mask_d]
								xorps xmm4,xmm2									;; y2 = xmm4
								movaps xmm5,xmmword ptr [one_ps]
								divps xmm5,xmm2									;; y = xmm5

								andps xmm5,xmm3
								andnps xmm3,xmm4
								orps xmm5,xmm3
								xorps xmm5,xmm1
	
								movaps xmmword ptr [r8],xmm5
								add rbx,16
								add r8,16
								sub rcx,4
								jnz @B

								mov rax,1

				Done:			ret
cot_sse_ps						endp


								end

