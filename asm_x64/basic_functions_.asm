include asm_x64_incs/basic_functions.inc

.code
;;			extern "C" bool maxs_sse_ps(float const* x,float const* y, int n, float *out);
;;													rcx,		rdx,		r8,		r9
maxs_sse_ps						proc uses rbx

								xor rax,rax
								;; first three checks are for alignment => this will be 
								;; removed once it is guaranteed through C++ object
								mov rbx,rcx
								test rbx,0fh
								jnz done

								test rdx,0fh
								jnz done

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm0,xmmword ptr [rbx]
								movaps xmm1,xmmword ptr [rdx]
								maxps xmm0,xmm1
								movaps xmmword ptr [r9],xmm0
								add rbx,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rbx]
								movaps xmm1,xmmword ptr [rdx]
								maxps xmm0,xmm1

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left
								jmp done

				one_left:		movss real4 ptr [r9],xmm0
								jmp done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm3,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm3

				done:			ret
maxs_sse_ps						endp

;;			extern "C" bool maxs_sse_pd(float const* x,float const* y, int n, float *out);
;;												rcx,			rdx,		r8,			r9
maxs_sse_pd						proc uses rbx,

								xor rax,rax
								;; first three checks are for alignment => this will be 
								;; removed once it is guaranteed through C++ object
								mov rbx,rcx
								test rbx,0fh
								jnz done

								test rdx,0fh
								jnz done

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								shr rcx,1
								and rax,1h

					@@:			movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmmword ptr [rdx]
								maxpd xmm0,xmm1
								movapd xmmword ptr [r9],xmm0
								add rbx,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmmword ptr [rdx]
								maxpd xmm0,xmm1
								movsd real8 ptr [r9],xmm0

				done:			ret
maxs_sse_pd						endp

;;			extern "C" bool mins_sse_ps(float const* x,float const* y, int n, float *out);
;;													rcx,		rdx,		r8,		r9
mins_sse_ps						proc uses rbx
								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz done

								test rdx,0fh
								jnz done

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm0,xmmword ptr [rbx]
								movaps xmm1,xmmword ptr [rdx]
								minps xmm0,xmm1
								movaps xmmword ptr [r9],xmm0
								add rbx,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rbx]
								movaps xmm1,xmmword ptr [rdx]
								minps xmm0,xmm1

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done

				two_left:		insertps xmm1,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm1
								jmp short done

				three_left:		insertps xmm1,xmm0,01000000b
								insertps xmm2,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm1
								movss real4 ptr [r9 + 8],xmm2

				done:			ret
mins_sse_ps						endp

;;			extern "C" bool mins_sse_pd(float const* x,float const* y, int n, float *out);
;;													rcx,		rdx,		r8,			r9
mins_sse_pd						proc uses rbx

								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz done

								test rdx,0fh
								jnz done

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								shr rcx,1
								and rax,1h

					@@:			movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmmword ptr [rdx]
								minpd xmm0,xmm1
								movapd xmmword ptr [r9],xmm0
								add rbx,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz short done

								movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmmword ptr [rdx]
								minpd xmm0,xmm1
								movsd real8 ptr [r9],xmm0

				done:			ret
mins_sse_pd						endp


;;			extern "C" bool abs_sse_ps(float const* x, int n, float* out);
;;												rcx,	rdx,			r8
abs_sse_ps						proc uses rbx
		
								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz done

								test r8,0fh
								jnz done

								mov rcx,rdx
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm0,xmmword ptr [rbx]
								andps xmm0,xmmword ptr [abs_mask_ps]
								movaps xmmword ptr [r8],xmm0
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rbx]
								andps xmm0,xmmword ptr [abs_mask_ps]
								
								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r8],xmm0
								jmp short done

				two_left:		insertps xmm1,xmm0,01000000b
								movss real4 ptr [r8],xmm0
								movss real4 ptr [r8 + 4],xmm1
								jmp short done

				three_left:		insertps xmm1,xmm0,01000000b
								insertps xmm2,xmm0,10000000b
								movss real4 ptr [r8],xmm0
								movss real4 ptr [r8 + 4],xmm1
								movss real4 ptr [r8 + 8],xmm2
			
				done:			ret
abs_sse_ps						endp

;;			extern "C" bool abs_sse_pd(double const* x, int n, double* out);
;;												rcx,	rdx,			r8
abs_sse_pd						proc uses rbx	
								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz done

								test r8,0fh
								jnz done

								mov rcx,rdx
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rbx]
								andpd xmm0,xmmword ptr [abs_mask_pd]
								movapd xmmword ptr [r8],xmm0
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movsd xmm0,real8 ptr [rbx]
								andpd xmm0,real8 ptr [abs_mask_pd]
								movsd real8 ptr [r8],xmm0
								
				done:			ret
abs_sse_pd						endp


;;			extern "C" bool sqrt_sse_pd(double const* x, int n, double* out);
;;													rcx,	rdx,		r8	
sqrt_sse_pd						proc uses rbx

								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz done

								test r8,0fh
								jnz done

								mov rcx,rdx
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rbx]
								sqrtpd xmm0,xmm0
								movapd xmmword ptr [r8],xmm0
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movsd xmm0,real8 ptr [rbx]
								sqrtsd xmm0,xmm0
								movsd real8 ptr [r8],xmm0

				done:			ret
sqrt_sse_pd						endp

;;			extern "C" bool sqrt_sse_ps(float const* x, int n, float* out);
;;													rcx,	rdx,		r8	
sqrt_sse_ps						proc uses rbx

								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz done

								test r8,0fh
								jnz done

								mov rcx,rdx
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2


					@@:			movaps xmm0,xmmword ptr [rbx]
								sqrtps xmm0,xmm0
								movaps xmmword ptr [r8],xmm0
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rbx]
								sqrtps xmm0,xmm0

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r8],xmm0
								jmp short done

				two_left:		insertps xmm1,xmm0,01000000b
								movss real4 ptr [r8],xmm0
								movss real4 ptr [r8 + 4],xmm1
								jmp short done

				three_left:		insertps xmm1,xmm0,01000000b
								insertps xmm2,xmm0,10000000b
								movss real4 ptr [r8],xmm0
								movss real4 ptr [r8 + 4],xmm1
								movss real4 ptr [r8 + 8],xmm2

				done:			ret
sqrt_sse_ps						endp

;;			extern "C" bool sqrpow_sse_pd(double const* x, int n, double* out);
;;													rcx,		rdx,		r8
sqrpow_sse_pd					proc uses rbx

								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz done

								test r8,0fh
								jnz done

								mov rcx,rdx
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rbx]
								mulpd xmm0,xmm0
								movapd xmmword ptr [r8],xmm0
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movsd xmm0,real8 ptr [rbx]
								mulsd xmm0,xmm0
								movsd real8 ptr [r8],xmm0

				done:			ret
sqrpow_sse_pd					endp

;;			extern "C" bool sqrpow_sse_ps(float const* x, int n, float* out);
;;													rcx,	rdx,		r8
sqrpow_sse_ps					proc uses rbx
								xor rax,rax

								mov rbx,rcx
								test rbx,0fh
								jnz done

								test r8,0fh
								jnz done

								mov rcx,rdx
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm0,xmmword ptr [rbx]
								mulps xmm0,xmm0
								movaps xmmword ptr [r8],xmm0
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rbx]
								mulps xmm0,xmm0

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r8],xmm0
								jmp short done

				two_left:		insertps xmm1,xmm0,01000000b
								movss real4 ptr [r8],xmm0
								movss real4 ptr [r8 + 4],xmm1
								jmp short done

				three_left:		insertps xmm1,xmm0,01000000b
								insertps xmm2,xmm0,10000000b
								movss real4 ptr [r8],xmm0
								movss real4 ptr [r8 + 4],xmm1
								movss real4 ptr [r8 + 8],xmm2

				done:			ret
sqrpow_sse_ps					endp
								end
