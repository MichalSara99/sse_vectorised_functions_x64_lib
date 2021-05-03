include asm_x64_incs/special_functions.inc

.code
;;		extern "C" bool erfc_sse_pd(double const* x, int n, double* out);
;;											rcx,		rdx,		r8
erfc_sse_pd					proc uses rbx
	
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

				 @@:		movapd xmm0,xmmword ptr [rbx]			;; x = xmm0
							mulpd xmm0,xmm0
							movapd xmm5,xmm0
							mulpd xmm0,xmmword ptr [minus_1_pd]
							movapd xmm1,xmmword ptr [log2e_pd]
							mulpd xmm1,xmm0							;; a = xmm1
							movapd xmm2,xmm1						;; a = xmm2
							xorpd xmm7,xmm7
							cmpltpd xmm2, xmm7
							movapd xmm6,xmmword ptr [plus_1_pd]
							andpd xmm2,xmm6							;; p = xmm2
							subpd xmm1,xmm2							;; a = xmm1
							cvttpd2dq xmm7, xmm1					;; k = xmm7
							cvtdq2pd xmm2, xmm7						;; p = xmm2

							movapd xmm3,xmmword ptr [c1_pd]
							movapd xmm4,xmmword ptr [c2_pd]
							movapd xmm6,xmm2

							mulpd xmm6,xmm3							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0
							movapd xmm6,xmm2

							mulpd xmm6,xmm4							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0

							movapd xmm3,xmmword ptr [m_ecoef_pd]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 16]
							movapd xmm6,xmm0
							mulpd xmm6,xmm3
							addpd xmm6,xmm4							;; a = xmm6

							movapd xmm3,xmmword ptr [m_ecoef_pd + 32]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 48]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 64]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 80]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 96]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 112]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 128]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 144]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 160]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 176]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							paddd xmm7,xmmword ptr [int_tentwothree]
							pslld xmm7,20
							pshufd xmm7, xmm7, 01110010b
							mulpd xmm6,xmm7

							mulpd xmm5,xmmword ptr [plus_pi_pd]
							movapd xmm0,xmm5
							movapd xmm1,xmmword ptr [plus_a_pd]
							mulpd xmm1,xmm1
							addpd xmm0,xmm1
							sqrtpd xmm0,xmm0
							sqrtpd xmm5,xmm5
							mulpd xmm5,xmmword ptr [plus_a_m_1_pd]
							addpd xmm5,xmm0
							movapd xmm0,xmmword ptr [plus_a_pd]
							divpd xmm0,xmm5
							mulpd xmm0,xmm6

							movapd xmmword ptr [r8],xmm0
							
							add rbx,16
							add r8,16
							dec rcx
							jnz @B

							mov rcx,rax
			too_short:		or rcx,rcx								
							mov rax,1
							jz done


							movapd xmm0,xmmword ptr [rbx]			;; x = xmm0
							mulpd xmm0,xmm0
							movapd xmm5,xmm0
							mulpd xmm0,xmmword ptr [minus_1_pd]
							movapd xmm1,xmmword ptr [log2e_pd]
							mulpd xmm1,xmm0							;; a = xmm1
							movapd xmm2,xmm1						;; a = xmm2
							xorpd xmm7,xmm7
							cmpltpd xmm2, xmm7
							movapd xmm6,xmmword ptr [plus_1_pd]
							andpd xmm2,xmm6							;; p = xmm2
							subpd xmm1,xmm2							;; a = xmm1
							cvttpd2dq xmm7, xmm1					;; k = xmm7
							cvtdq2pd xmm2, xmm7						;; p = xmm2

							movapd xmm3,xmmword ptr [c1_pd]
							movapd xmm4,xmmword ptr [c2_pd]
							movapd xmm6,xmm2

							mulpd xmm6,xmm3							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0
							movapd xmm6,xmm2

							mulpd xmm6,xmm4							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0

							movapd xmm3,xmmword ptr [m_ecoef_pd]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 16]
							movapd xmm6,xmm0
							mulpd xmm6,xmm3
							addpd xmm6,xmm4							;; a = xmm6

							movapd xmm3,xmmword ptr [m_ecoef_pd + 32]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 48]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 64]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 80]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 96]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 112]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 128]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 144]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 160]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 176]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							paddd xmm7,xmmword ptr [int_tentwothree]
							pslld xmm7,20
							pshufd xmm7, xmm7, 01110010b
							mulpd xmm6,xmm7

							mulpd xmm5,xmmword ptr [plus_pi_pd]
							movapd xmm0,xmm5
							movapd xmm1,xmmword ptr [plus_a_pd]
							mulpd xmm1,xmm1
							addpd xmm0,xmm1
							sqrtpd xmm0,xmm0
							sqrtpd xmm5,xmm5
							mulpd xmm5,xmmword ptr [plus_a_m_1_pd]
							addpd xmm5,xmm0
							movapd xmm0,xmmword ptr [plus_a_pd]
							divpd xmm0,xmm5
							mulpd xmm0,xmm6

							movsd real8 ptr [r8],xmm0

				done:		ret
erfc_sse_pd					endp

;;		extern "C" bool erfc_sse_ps(float const* x, int n, float * out);
;;											rcx,		rdx,		r8
erfc_sse_ps					proc uses rbx

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

				  @@:		movaps xmm0,xmmword ptr [rbx]				;; x = xmm0

				  			mulps xmm0,xmm0
							movaps xmm5,xmm0
							mulps xmm0,xmmword ptr [minus_1_ps]
							movaps xmm1,xmm0							
							mulps xmm1,xmmword ptr [log2e_ps]			
							addps xmm1,xmmword ptr [zero_point_five]	;; fx = xmm1
							roundps xmm2,xmm1,0001b						;; tmp = xmm2
							movaps xmm3,xmm2
							cmpps xmm3,xmm1,0eh							
							andps xmm3,xmmword ptr [plus_1_ps]				;; mask = xmm3
							movaps xmm4,xmm2
							subps xmm4,xmm3								;; fx = xmm4
							movaps xmm1,xmm4
							mulps xmm1,xmmword ptr [c1_ps]				;; tmp = xmm1
							movaps xmm2,xmm4
							mulps xmm2,xmmword ptr [c2_ps]				;; z = xmm2
							subps xmm0,xmm1								;; x = xmm0
							subps xmm0,xmm2
							movaps xmm2,xmm0
							mulps xmm2,xmm2								;; z = xmm2

							movaps xmm1,xmmword ptr [m_ecoef_ps]		;; y = xmm1
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 16]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 32]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 48]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 64]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 80]
							mulps xmm1,xmm2
							addps xmm1,xmm0
							addps xmm1,xmmword ptr [plus_1_ps]

							cvttps2dq xmm3,xmm4
							paddd xmm3,xmmword ptr [int_onetwoseven]
							pslld xmm3,23
							mulps xmm3,xmm1

							mulps xmm5,xmmword ptr [plus_pi_ps]
							movaps xmm0,xmm5
							movaps xmm1,xmmword ptr [plus_a_ps]
							mulps xmm1,xmm1
							addps xmm0,xmm1
							sqrtps xmm0,xmm0
							sqrtps xmm5,xmm5
							mulps xmm5,xmmword ptr [plus_a_m_1_ps]
							addps xmm5,xmm0
							movaps xmm0,xmmword ptr [plus_a_ps]
							divps xmm0,xmm5
							mulps xmm0,xmm3

							movaps xmmword ptr [r8],xmm0
							
							add rbx,16
							add r8,16
							dec rcx
							jnz @B

							mov rcx,rax
			too_short:		or rcx,rcx
							mov rax,1
							jz done

							movaps xmm0,xmmword ptr [rbx]				;; x = xmm0
				  			mulps xmm0,xmm0
							movaps xmm5,xmm0
							mulps xmm0,xmmword ptr [minus_1_ps]
							movaps xmm1,xmm0							
							mulps xmm1,xmmword ptr [log2e_ps]			
							addps xmm1,xmmword ptr [zero_point_five]	;; fx = xmm1
							roundps xmm2,xmm1,0001b						;; tmp = xmm2
							movaps xmm3,xmm2
							cmpps xmm3,xmm1,0eh							
							andps xmm3,xmmword ptr [plus_1_ps]				;; mask = xmm3
							movaps xmm4,xmm2
							subps xmm4,xmm3								;; fx = xmm4
							movaps xmm1,xmm4
							mulps xmm1,xmmword ptr [c1_ps]				;; tmp = xmm1
							movaps xmm2,xmm4
							mulps xmm2,xmmword ptr [c2_ps]				;; z = xmm2
							subps xmm0,xmm1								;; x = xmm0
							subps xmm0,xmm2
							movaps xmm2,xmm0
							mulps xmm2,xmm2								;; z = xmm2

							movaps xmm1,xmmword ptr [m_ecoef_ps]		;; y = xmm1
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 16]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 32]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 48]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 64]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 80]
							mulps xmm1,xmm2
							addps xmm1,xmm0
							addps xmm1,xmmword ptr [plus_1_ps]

							cvttps2dq xmm3,xmm4
							paddd xmm3,xmmword ptr [int_onetwoseven]
							pslld xmm3,23
							mulps xmm3,xmm1

							mulps xmm5,xmmword ptr [plus_pi_ps]
							movaps xmm0,xmm5
							movaps xmm1,xmmword ptr [plus_a_ps]
							mulps xmm1,xmm1
							addps xmm0,xmm1
							sqrtps xmm0,xmm0
							sqrtps xmm5,xmm5
							mulps xmm5,xmmword ptr [plus_a_m_1_ps]
							addps xmm5,xmm0
							movaps xmm0,xmmword ptr [plus_a_ps]
							divps xmm0,xmm5
							mulps xmm0,xmm3

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

				done:		ret
erfc_sse_ps					endp

;;		extern "C" bool erf_sse_pd(double const* x, int n, double* out);
;;											rcx,	rdx,			r8
erf_sse_pd					proc uses rbx

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

				 @@:		movapd xmm0,xmmword ptr [rbx]			;; x = xmm0
							mulpd xmm0,xmm0
							movapd xmm5,xmm0
							mulpd xmm0,xmmword ptr [minus_1_pd]
							movapd xmm1,xmmword ptr [log2e_pd]
							mulpd xmm1,xmm0							;; a = xmm1
							movapd xmm2,xmm1						;; a = xmm2
							xorpd xmm7,xmm7
							cmpltpd xmm2, xmm7
							movapd xmm6,xmmword ptr [plus_1_pd]
							andpd xmm2,xmm6							;; p = xmm2
							subpd xmm1,xmm2							;; a = xmm1
							cvttpd2dq xmm7, xmm1					;; k = xmm7
							cvtdq2pd xmm2, xmm7						;; p = xmm2

							movapd xmm3,xmmword ptr [c1_pd]
							movapd xmm4,xmmword ptr [c2_pd]
							movapd xmm6,xmm2

							mulpd xmm6,xmm3							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0
							movapd xmm6,xmm2

							mulpd xmm6,xmm4							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0

							movapd xmm3,xmmword ptr [m_ecoef_pd]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 16]
							movapd xmm6,xmm0
							mulpd xmm6,xmm3
							addpd xmm6,xmm4							;; a = xmm6

							movapd xmm3,xmmword ptr [m_ecoef_pd + 32]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 48]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 64]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 80]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 96]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 112]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 128]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 144]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 160]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 176]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							paddd xmm7,xmmword ptr [int_tentwothree]
							pslld xmm7,20
							pshufd xmm7, xmm7, 01110010b
							mulpd xmm6,xmm7

							mulpd xmm5,xmmword ptr [plus_pi_pd]
							movapd xmm0,xmm5
							movapd xmm1,xmmword ptr [plus_a_pd]
							mulpd xmm1,xmm1
							addpd xmm0,xmm1
							sqrtpd xmm0,xmm0
							sqrtpd xmm5,xmm5
							mulpd xmm5,xmmword ptr [plus_a_m_1_pd]
							addpd xmm5,xmm0
							movapd xmm0,xmmword ptr [plus_a_pd]
							divpd xmm0,xmm5
							mulpd xmm0,xmm6

							movapd xmm1,xmmword ptr [plus_1_pd]
							subpd xmm1,xmm0
							movapd xmmword ptr [r8],xmm1
							
							add rbx,16
							add r8,16
							dec rcx
							jnz @B

							mov rcx,rax
			too_short:		or rcx,rcx	
							mov rax,1
							jz done

							movapd xmm0,xmmword ptr [rbx]			;; x = xmm0
							mulpd xmm0,xmm0
							movapd xmm5,xmm0
							mulpd xmm0,xmmword ptr [minus_1_pd]
							movapd xmm1,xmmword ptr [log2e_pd]
							mulpd xmm1,xmm0							;; a = xmm1
							movapd xmm2,xmm1						;; a = xmm2
							xorpd xmm7,xmm7
							cmpltpd xmm2, xmm7
							movapd xmm6,xmmword ptr [plus_1_pd]
							andpd xmm2,xmm6							;; p = xmm2
							subpd xmm1,xmm2							;; a = xmm1
							cvttpd2dq xmm7, xmm1					;; k = xmm7
							cvtdq2pd xmm2, xmm7						;; p = xmm2

							movapd xmm3,xmmword ptr [c1_pd]
							movapd xmm4,xmmword ptr [c2_pd]
							movapd xmm6,xmm2

							mulpd xmm6,xmm3							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0
							movapd xmm6,xmm2

							mulpd xmm6,xmm4							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0

							movapd xmm3,xmmword ptr [m_ecoef_pd]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 16]
							movapd xmm6,xmm0
							mulpd xmm6,xmm3
							addpd xmm6,xmm4							;; a = xmm6

							movapd xmm3,xmmword ptr [m_ecoef_pd + 32]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 48]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 64]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 80]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 96]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 112]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 128]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 144]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 160]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 176]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							paddd xmm7,xmmword ptr [int_tentwothree]
							pslld xmm7,20
							pshufd xmm7, xmm7, 01110010b
							mulpd xmm6,xmm7

							mulpd xmm5,xmmword ptr [plus_pi_pd]
							movapd xmm0,xmm5
							movapd xmm1,xmmword ptr [plus_a_pd]
							mulpd xmm1,xmm1
							addpd xmm0,xmm1
							sqrtpd xmm0,xmm0
							sqrtpd xmm5,xmm5
							mulpd xmm5,xmmword ptr [plus_a_m_1_pd]
							addpd xmm5,xmm0
							movapd xmm0,xmmword ptr [plus_a_pd]
							divpd xmm0,xmm5
							mulpd xmm0,xmm6

							movapd xmm1,xmmword ptr [plus_1_pd]
							subpd xmm1,xmm0

							movsd real8 ptr [r8],xmm1

				done:		ret
erf_sse_pd					endp

;;		extern "C" bool erf_sse_ps(float const* x, int n, float * out);
;;											rcx,		rdx,		r8
erf_sse_ps					proc uses rbx

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

				  @@:		movaps xmm0,xmmword ptr [rbx]				;; x = xmm0
				  			mulps xmm0,xmm0
							movaps xmm5,xmm0
							mulps xmm0,xmmword ptr [minus_1_ps]
							movaps xmm1,xmm0							
							mulps xmm1,xmmword ptr [log2e_ps]			
							addps xmm1,xmmword ptr [zero_point_five]	;; fx = xmm1
							roundps xmm2,xmm1,0001b						;; tmp = xmm2
							movaps xmm3,xmm2
							cmpps xmm3,xmm1,0eh							
							andps xmm3,xmmword ptr [plus_1_ps]				;; mask = xmm3
							movaps xmm4,xmm2
							subps xmm4,xmm3								;; fx = xmm4
							movaps xmm1,xmm4
							mulps xmm1,xmmword ptr [c1_ps]				;; tmp = xmm1
							movaps xmm2,xmm4
							mulps xmm2,xmmword ptr [c2_ps]				;; z = xmm2
							subps xmm0,xmm1								;; x = xmm0
							subps xmm0,xmm2
							movaps xmm2,xmm0
							mulps xmm2,xmm2								;; z = xmm2

							movaps xmm1,xmmword ptr [m_ecoef_ps]		;; y = xmm1
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 16]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 32]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 48]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 64]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 80]
							mulps xmm1,xmm2
							addps xmm1,xmm0
							addps xmm1,xmmword ptr [plus_1_ps]

							cvttps2dq xmm3,xmm4
							paddd xmm3,xmmword ptr [int_onetwoseven]
							pslld xmm3,23
							mulps xmm3,xmm1

							mulps xmm5,xmmword ptr [plus_pi_ps]
							movaps xmm0,xmm5
							movaps xmm1,xmmword ptr [plus_a_ps]
							mulps xmm1,xmm1
							addps xmm0,xmm1
							sqrtps xmm0,xmm0
							sqrtps xmm5,xmm5
							mulps xmm5,xmmword ptr [plus_a_m_1_ps]
							addps xmm5,xmm0
							movaps xmm0,xmmword ptr [plus_a_ps]
							divps xmm0,xmm5
							mulps xmm0,xmm3

							movaps xmm1,xmmword ptr [plus_1_ps]
							subps xmm1,xmm0
							movaps xmmword ptr [r8],xmm1
							
							add rbx,16
							add r8,16
							dec rcx
							jnz @B

							mov rcx,rax
			too_short:		or rcx,rcx
							mov rax,1
							jz done

							movaps xmm0,xmmword ptr [rbx]				;; x = xmm0
				  			mulps xmm0,xmm0
							movaps xmm5,xmm0
							mulps xmm0,xmmword ptr [minus_1_ps]
							movaps xmm1,xmm0							
							mulps xmm1,xmmword ptr [log2e_ps]			
							addps xmm1,xmmword ptr [zero_point_five]	;; fx = xmm1
							roundps xmm2,xmm1,0001b						;; tmp = xmm2
							movaps xmm3,xmm2
							cmpps xmm3,xmm1,0eh							
							andps xmm3,xmmword ptr [plus_1_ps]				;; mask = xmm3
							movaps xmm4,xmm2
							subps xmm4,xmm3								;; fx = xmm4
							movaps xmm1,xmm4
							mulps xmm1,xmmword ptr [c1_ps]				;; tmp = xmm1
							movaps xmm2,xmm4
							mulps xmm2,xmmword ptr [c2_ps]				;; z = xmm2
							subps xmm0,xmm1								;; x = xmm0
							subps xmm0,xmm2
							movaps xmm2,xmm0
							mulps xmm2,xmm2								;; z = xmm2

							movaps xmm1,xmmword ptr [m_ecoef_ps]		;; y = xmm1
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 16]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 32]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 48]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 64]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [m_ecoef_ps + 80]
							mulps xmm1,xmm2
							addps xmm1,xmm0
							addps xmm1,xmmword ptr [plus_1_ps]

							cvttps2dq xmm3,xmm4
							paddd xmm3,xmmword ptr [int_onetwoseven]
							pslld xmm3,23
							mulps xmm3,xmm1

							mulps xmm5,xmmword ptr [plus_pi_ps]
							movaps xmm0,xmm5
							movaps xmm1,xmmword ptr [plus_a_ps]
							mulps xmm1,xmm1
							addps xmm0,xmm1
							sqrtps xmm0,xmm0
							sqrtps xmm5,xmm5
							mulps xmm5,xmmword ptr [plus_a_m_1_ps]
							addps xmm5,xmm0
							movaps xmm0,xmmword ptr [plus_a_ps]
							divps xmm0,xmm5
							mulps xmm0,xmm3

							movaps xmm1,xmmword ptr [plus_1_ps]
							subps xmm1,xmm0

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

				done:		ret
erf_sse_ps					endp
							end
