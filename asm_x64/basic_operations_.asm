include asm_x64_incs/basic_operations.inc

.code

;;				extern "C" bool mul_br_sse_pd(double const* x, double const y, int n, double* out);
;;														rcx,			xmm1,	r8,		r9
mul_br_sse_pd					proc uses rsi

								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
								jnz done

								movsd xmm6,xmm1
								movlhps xmm6,xmm6	

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rsi]
								mulpd xmm0,xmm6
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rsi]
								mulpd xmm0,xmm6
								movsd real8 ptr [r9],xmm0

				done:			ret
mul_br_sse_pd					endp

;;				extern "C" bool mul_br_sse_ps(float const* x, float const y, int n, float* out);
;;														rcx,		xmm1,	r8,	r9
mul_br_sse_ps					proc uses rsi
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
								jnz done

								vbroadcastss xmm6,xmm1

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm0,xmmword ptr [rsi]
								mulps xmm0,xmm6
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rsi]
								mulps xmm0,xmm6

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
mul_br_sse_ps					endp
								
;;				extern "C" bool div_br_sse_ps(float const* x, float const y, int n, float* out);
;;													rcx,			xmm1,	r8,		r9
div_br_sse_ps					proc uses rsi
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
								jnz done

								vbroadcastss xmm6,xmm1

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm0,xmmword ptr [rsi]
								divps xmm0,xmm6
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rsi]
								divps xmm0,xmm6

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
div_br_sse_ps					endp

;;				extern "C" bool div_br_sse_pd(double const* x, double const y, int n, double* out);
;;												rcx,			xmm1,			r8,		r9
div_br_sse_pd					proc uses rsi
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
								jnz done

								movsd xmm7,xmm1
								movlhps xmm7,xmm7

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rsi]
								divpd xmm0,xmm7
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rsi]
								divpd xmm0,xmm7
								movsd real8 ptr [r9],xmm0

				done:			ret
div_br_sse_pd					endp


;;				extern "C" bool div_br_sse_ps(float const x, float const *y, int n, float* out);
;;												xmm0,		rdx,		r8,		r9
div_br_s_sse_ps					proc uses rsi
								
								xor rax,rax

								mov rsi,rdx
								test rsi,0fh
								jnz done

								vbroadcastss xmm6,xmm0

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm1,xmmword ptr [rsi]
								movaps xmm0,xmm6
								divps xmm0,xmm1
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm1,xmmword ptr [rsi]
								movaps xmm0,xmm6
								divps xmm0,xmm1

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
div_br_s_sse_ps					endp

;;				extern "C" bool div_br_sse_pd(double const x, double const *y, int n, double* out);
;;														xmm0,		rdx,		r8,		r9		
div_br_s_sse_pd					proc uses rsi
								
								xor rax,rax

								mov rsi,rdx
								test rsi,0fh
								jnz done

								movsd xmm7,xmm0
								movlhps xmm7,xmm7

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm1,xmmword ptr [rsi]
								movapd xmm0,xmm7
								divpd xmm0,xmm1
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movapd xmm1,xmmword ptr [rsi]
								movapd xmm0,xmm7
								divpd xmm0,xmm1
								movsd real8 ptr [r9],xmm0

				done:			ret
div_br_s_sse_pd					endp



;;				extern "C" bool add_br_sse_ps(float const* x, float const y, int n, float* out);
;;														rcx,		xmm1,		r8,		r9
add_br_sse_ps					proc uses rsi
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
								jnz done

								vbroadcastss xmm6,xmm1

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm0,xmmword ptr [rsi]
								addps xmm0,xmm6
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rsi]
								addps xmm0,xmm6

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
add_br_sse_ps					endp

;;				extern "C" bool add_br_sse_pd(double const* x, double const y, int n, double* out);
;;														rcx,			xmm1,	r8,			r9
add_br_sse_pd					proc uses rsi
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
								jnz done

								movsd xmm7,xmm1
								movlhps xmm6,xmm7

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rsi]
								addpd xmm0,xmm6
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rsi]
								addpd xmm0,xmm6

								movsd real8 ptr [r9],xmm0

				done:			ret
add_br_sse_pd					endp

;;				extern "C" bool sub_br_sse_ps(float const* x, float const y, int n, float* out);
;;														rcx,		xmm1,		r8,			r9
sub_br_sse_ps					proc uses rsi
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
								jnz done

								vbroadcastss xmm6,xmm1

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm0,xmmword ptr [rsi]
								subps xmm0,xmm6
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rsi]
								subps xmm0,xmm6

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
sub_br_sse_ps					endp

;;				extern "C" bool sub_br_sse_pd(double const* x, double const y, int n, double* out);
;;														rcx,			xmm1,	r8,			r9
sub_br_sse_pd					proc uses rsi
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
								jnz done

								movsd xmm7,xmm1
								movlhps xmm6,xmm7

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rsi]
								subpd xmm0,xmm6
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rsi]
								subpd xmm0,xmm6
								movsd real8 ptr [r9],xmm0

				done:			ret
sub_br_sse_pd					endp

;;				extern "C" bool sub_br_sse_ps(float const x, float const* y, int n, float* out);
;;													xmm0,			rdx,		r8,		r9
sub_br_s_sse_ps					proc uses rsi
								
								xor rax,rax

								mov rsi,rdx
								test rsi,0fh
								jnz done

								vbroadcastss xmm6,xmm0

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,4
								jl too_short

								mov rax,rcx
								and rcx,0fffffffch
								sub rax,rcx
								shr rcx,2

					@@:			movaps xmm1,xmmword ptr [rsi]
								movaps xmm0,xmm6
								subps xmm0,xmm1
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movaps xmm1,xmmword ptr [rsi]
								movaps xmm0,xmm6
								subps xmm0,xmm1

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
sub_br_s_sse_ps					endp

;;				extern "C" bool sub_br_sse_pd(double const x, double const *y, int n, double* out);
;;														xmm0,			rdx,	r8,		r9
sub_br_s_sse_pd					proc uses rsi
								
								xor rax,rax

								mov rsi,rdx
								test rsi,0fh
								jnz done

								movsd xmm7,xmm0
								movlhps xmm6,xmm7

								test r9,0fh
								jnz done

								mov rcx,r8
								cmp rcx,2
								jl too_short

								mov rax,rcx
								and rcx,0fffffffeh
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm1,xmmword ptr [rsi]
								movapd xmm0,xmm6
								subpd xmm0,xmm1
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movapd xmm1,xmmword ptr [rsi]
								movapd xmm0,xmm6
								subpd xmm0,xmm1
								movsd real8 ptr [r9],xmm0

				done:			ret
sub_br_s_sse_pd					endp

;;				extern "C" bool mul_sse_ps(float const* x, float const* y, int n, float* out);
;;													rcx,			rdx,	r8,			r9
mul_sse_ps						proc uses rsi
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
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

					@@:			movaps xmm0,xmmword ptr [rsi]
								movaps xmm1,xmmword ptr [rdx]
								mulps xmm0,xmm1
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rsi]
								movaps xmm1,xmmword ptr [rdx]
								mulps xmm0,xmm1

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
mul_sse_ps						endp

;;				extern "C" bool mul_sse_pd(double const* x, double const* y, int n, double* out);
;;													rcx,			rdx,		r8,			r9
mul_sse_pd						proc uses rsi,

								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
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
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rsi]
								movapd xmm1,xmmword ptr [rdx]
								mulpd xmm0,xmm1
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rsi]
								movapd xmm1,xmmword ptr [rdx]
								mulpd xmm0,xmm1
								movsd real8 ptr [r9],xmm0

				done:			ret
mul_sse_pd						endp

;;				extern "C" bool div_sse_ps(float const* x, float const* y, int n, float* out);
;;													rcx,			rdx,	 r8,		 r9		
div_sse_ps						proc uses rsi,
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
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

					@@:			movaps xmm0,xmmword ptr [rsi]
								movaps xmm1,xmmword ptr [rdx]
								divps xmm0,xmm1
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add rdx,16
								add r9,16
								dec ecx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rsi]
								movaps xmm1,xmmword ptr [rdx]
								divps xmm0,xmm1

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
div_sse_ps						endp

;;				extern "C" bool div_sse_pd(double const* x, double const* y, int n, double* out);
;;													rcx,				rdx,	r8,			r9
div_sse_pd						proc uses rsi,
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
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
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rsi]
								movapd xmm1,xmmword ptr [rdx]
								divpd xmm0,xmm1
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rsi]
								movapd xmm1,xmmword ptr [rdx]
								divpd xmm0,xmm1
								movsd real8 ptr [r9],xmm0

				done:			ret
div_sse_pd						endp




;;				extern "C" bool add_sse_ps(float const* x, float const* y, int n, float* out);
;;													rcx,			rdx,	 r8,		r9	
add_sse_ps						proc uses rsi,
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
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

					@@:			movaps xmm0,xmmword ptr [rsi]
								movaps xmm1,xmmword ptr [rdx]
								addps xmm0,xmm1
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rsi]
								movaps xmm1,xmmword ptr [rdx]
								addps xmm0,xmm1

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
add_sse_ps						endp

;;				extern "C" bool add_sse_pd(double const* x, double const* y, int n, double* out);
;;													rcx,			rdx,		r8,			r9
add_sse_pd						proc uses rsi,
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
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
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rsi]
								movapd xmm1,xmmword ptr [rdx]
								addpd xmm0,xmm1
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rsi]
								movapd xmm1,xmmword ptr [rdx]
								addpd xmm0,xmm1

								movsd real8 ptr [r9],xmm0

				done:			ret
add_sse_pd						endp

;;				extern "C" bool sub_sse_ps(float const* x, float const* y, int n, float* out);
;;													rcx,			rdx,	  r8,		  r9		
sub_sse_ps						proc uses rsi,
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
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

					@@:			movaps xmm0,xmmword ptr [rsi]
								movaps xmm1,xmmword ptr [rdx]
								subps xmm0,xmm1
								movaps xmmword ptr [r9],xmm0
								add rsi,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rsi]
								movaps xmm1,xmmword ptr [rdx]
								subps xmm0,xmm1

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r9],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r9],xmm0
								movss real4 ptr [r9 + 4],xmm2
								movss real4 ptr [r9 + 8],xmm4

				done:			ret
sub_sse_ps						endp

;;				extern "C" bool sub_sse_pd(double const* x, double const* y, int n, double* out);
;;													rcx,			rdx,		r8,			r9
sub_sse_pd						proc uses rsi,
								
								xor rax,rax

								mov rsi,rcx
								test rsi,0fh
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
								sub rax,rcx
								shr rcx,1

					@@:			movapd xmm0,xmmword ptr [rsi]
								movapd xmm1,xmmword ptr [rdx]
								subpd xmm0,xmm1
								movapd xmmword ptr [r9],xmm0
								add rsi,16
								add rdx,16
								add r9,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rsi]
								movapd xmm1,xmmword ptr [rdx]
								subpd xmm0,xmm1
								movsd real8 ptr [r9],xmm0

				done:			ret
sub_sse_pd						endp

;;			extern "C" bool neg_sse_pd(double const* x, int n, double* out);
;;												rcx,		rdx,		r8
neg_sse_pd						proc uses rbx,

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
								xorpd xmm0,xmmword ptr [int_neg_mask_pd]
								movapd xmmword ptr [r8],xmm0
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rbx]
								xorpd xmm0,xmmword ptr [int_neg_mask_pd]
								movsd real8 ptr [r8],xmm0

				done:			ret
neg_sse_pd						endp

;;			extern "C" bool neg_sse_ps(float const* x, int n, float* out);
;;												rcx,	  rdx,		r8
neg_sse_ps						proc uses rbx,

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
								xorps xmm0,xmmword ptr [int_neg_mask_ps]
								movaps xmmword ptr [r8],xmm0
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rbx]
								xorps xmm0,xmmword ptr [int_neg_mask_ps]

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r8],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [r8],xmm0
								movss real4 ptr [r8 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [r8],xmm0
								movss real4 ptr [r8 + 4],xmm2
								movss real4 ptr [r8 + 8],xmm4

				done:			ret
neg_sse_ps						endp

;;			extern "C" bool inv_sse_pd(double const* x, int n, double* out);
;;												rcx,	 rdx,			r8	
inv_sse_pd						proc uses rbx,

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
								movapd xmm1,xmmword ptr [plus_1_pd]
								divpd xmm1,xmm0
								movapd xmmword ptr [r8],xmm1
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmmword ptr [plus_1_pd]
								divpd xmm1,xmm0
								movsd real8 ptr [r8],xmm1

				done:			ret
inv_sse_pd						endp

;;			extern "C" bool inv_sse_ps(float const* x, int n, float* out);
;;												rcx,	  rdx,			r8	
inv_sse_ps						proc uses rbx,

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
								movaps xmm1,xmmword ptr [plus_1_ps]
								divps xmm1,xmm0
								movaps xmmword ptr [r8],xmm1
								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								movaps xmm0,xmmword ptr [rbx]
								movaps xmm1,xmmword ptr [plus_1_ps]
								divps xmm1,xmm0

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r8],xmm1
								jmp short done
				two_left:		insertps xmm2,xmm1,01000000b
								movss real4 ptr [r8],xmm1
								movss real4 ptr [r8 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm1,01000000b
								insertps xmm4,xmm1,10000000b
								movss real4 ptr [r8],xmm1
								movss real4 ptr [r8 + 4],xmm2
								movss real4 ptr [r8 + 8],xmm4

				done:			ret
inv_sse_ps						endp


								end
