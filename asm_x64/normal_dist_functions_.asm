include asm_x64_incs/normal_dist_functions.inc

.code
;;		extern "C" bool norm_pdf_sse_pd(double const* x, int n, double* out);
;;													rcx,	rdx,		r8
norm_pdf_sse_pd					proc uses rbx
	
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
								mulpd xmm0,xmmword ptr [minus_0p5_pd]
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
								mulpd xmm6,xmmword ptr [one_o_sqrttwopi_pd]

								movapd xmmword ptr [r8],xmm6
							
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
								mulpd xmm0,xmmword ptr [minus_0p5_pd]
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
								mulpd xmm6,xmmword ptr [one_o_sqrttwopi_pd]

								movsd real8 ptr [r8],xmm6

					done:		ret
norm_pdf_sse_pd					endp

;;		extern "C" bool norm_pdf_sse_ps(float const* x, int n, float * out);
;;												rcx,	rdx,			r8
norm_pdf_sse_ps					proc uses rbx
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
								mulps xmm0,xmmword ptr [minus_0p5_ps]
								movaps xmm1,xmm0							
								mulps xmm1,xmmword ptr [log2e_ps]			
								addps xmm1,xmmword ptr [plus_0p5_ps]	;; fx = xmm1
								roundps xmm2,xmm1,0001b						;; tmp = xmm2
								movaps xmm3,xmm2
								cmpps xmm3,xmm1,0eh							
								andps xmm3,xmmword ptr [plus_1_ps]			;; mask = xmm3
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
								mulps xmm3,xmmword ptr [one_o_sqrttwopi_ps]
								movaps xmmword ptr [r8],xmm3
							
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
								mulps xmm0,xmmword ptr [minus_0p5_ps]
								movaps xmm1,xmm0							
								mulps xmm1,xmmword ptr [log2e_ps]			
								addps xmm1,xmmword ptr [plus_0p5_ps]	;; fx = xmm1
								roundps xmm2,xmm1,0001b						;; tmp = xmm2
								movaps xmm3,xmm2
								cmpps xmm3,xmm1,0eh							
								andps xmm3,xmmword ptr [plus_1_ps]			;; mask = xmm3
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
								mulps xmm3,xmmword ptr [one_o_sqrttwopi_ps]

								cmp rcx,1
								je short one_left
								cmp rcx,2
								je short two_left
								cmp rcx,3
								je short three_left

				one_left:		movss real4 ptr [r8],xmm3
								jmp short done
				two_left:		insertps xmm2,xmm3,01000000b
								movss real4 ptr [r8],xmm3
								movss real4 ptr [r8 + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm3,01000000b
								insertps xmm4,xmm3,10000000b
								movss real4 ptr [r8],xmm3
								movss real4 ptr [r8 + 4],xmm2
								movss real4 ptr [r8 + 8],xmm4

					done:		ret
norm_pdf_sse_ps					endp


;;			extern "C" bool norm_inv_cdf_sse_ps(float const* x, int n, float* out);
;;														rcx,		rdx,		r8
norm_inv_cdf_sse_ps				proc uses rbx

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

					  @@:		movaps xmm0,xmmword ptr [rbx]						;; x = xmm0
								movaps xmm1,xmm0
								xorps xmm7,xmm7
								cmpps xmm1,xmm7,02h									;; inval_mask = xmm1

								movaps xmm7,xmm0
								cmpps xmm7,xmmword ptr [plus_0p5_ps],06h
								andps xmm7,xmmword ptr [plus_1_ps]					;; ind = xmm7 

								movaps xmm6,xmm0
								cmpps xmm6,xmmword ptr [plus_0p5_ps],06h
								andps xmm6,xmmword ptr [plus_2_ps]					
								subps xmm6,xmmword ptr [plus_1_ps]					;; inv = xmm6	

								maxps xmm0,xmmword ptr [int_min_norm]				;; x = xmm0
								subps xmm7,xmm0
								andps xmm7,xmmword ptr [int_float_abs_mask_ps]
								movaps xmm0,xmm7

								movaps xmm2,xmm0									
								psrld xmm2,23										;; imm0 = xmm2

								movaps xmm3,xmmword ptr [int_mantisa]
								pandn xmm3,xmmword ptr [int_one]

								andps xmm0,xmm3
								orps xmm0,xmmword ptr [plus_0p5_ps]

								psubd xmm2,xmmword ptr [int_onetwoseven]
								cvtdq2ps xmm3,xmm2									
								addps xmm3,xmmword ptr [plus_1_ps]					;; e = xmm3

								movaps xmm4,xmm0
								cmpps xmm4,xmmword ptr [sqrthf_ps],01h				;; mask = xmm4
								movaps xmm5,xmm0
								andps xmm5,xmm4										;; tmp = xmm5

								subps xmm0,xmmword ptr [plus_1_ps]
								andps xmm4,xmmword ptr [plus_1_ps]
								subps xmm3,xmm4
								addps xmm0,xmm5

								movaps xmm2,xmm0
								mulps xmm2,xmm2										;; z = xmm2
								movaps xmm4,xmmword ptr [m_lcoef_ps]				;; y = xmm4

								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 16]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 32]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 48]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 64]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 80]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 96]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 112]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 128]
								mulps xmm4,xmm0
								mulps xmm4,xmm2

								movaps xmm5,xmm3
								mulps xmm5,xmmword ptr [log_q1_ps]
								addps xmm4,xmm5

								movaps xmm5,xmm2
								mulps xmm5,xmmword ptr [plus_0p5_ps]
								subps xmm4,xmm5

								movaps xmm5,xmm3
								mulps xmm5,xmmword ptr [log_q2_ps]
								addps xmm0,xmm4
								addps xmm0,xmm5
								orps xmm0,xmm1
								mulps xmm0,xmmword ptr [minus_2_ps]
								sqrtps xmm0,xmm0									;; x = xmm0

								movaps xmm2,xmm0
								mulps xmm2,xmmword ptr [m_rcoef_ps + 32]
								addps xmm2,xmmword ptr [m_rcoef_ps + 16]
								mulps xmm2,xmm0
								addps xmm2,xmmword ptr [m_rcoef_ps]

								movaps xmm3,xmm0
								mulps xmm3,xmmword ptr [m_rcoef_ps + 80]
								addps xmm3,xmmword ptr [m_rcoef_ps + 64]
								mulps xmm3,xmm0
								addps xmm3,xmmword ptr [m_rcoef_ps + 48]
								mulps xmm3,xmm0
								addps xmm3,xmmword ptr [plus_1_ps]
								divps xmm2,xmm3
								subps xmm0,xmm2
								mulps xmm0,xmm6

								movaps xmmword ptr [r8],xmm0

								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done


								movaps xmm0,xmmword ptr [rbx]						;; x = xmm0
								movaps xmm1,xmm0
								xorps xmm7,xmm7
								cmpps xmm1,xmm7,02h									;; inval_mask = xmm1

								movaps xmm7,xmm0
								cmpps xmm7,xmmword ptr [plus_0p5_ps],06h
								andps xmm7,xmmword ptr [plus_1_ps]					;; ind = xmm7 

								movaps xmm6,xmm0
								cmpps xmm6,xmmword ptr [plus_0p5_ps],06h
								andps xmm6,xmmword ptr [plus_2_ps]					
								subps xmm6,xmmword ptr [plus_1_ps]					;; inv = xmm6	

								maxps xmm0,xmmword ptr [int_min_norm]				;; x = xmm0
								subps xmm7,xmm0
								andps xmm7,xmmword ptr [int_float_abs_mask_ps]
								movaps xmm0,xmm7

								movaps xmm2,xmm0									
								psrld xmm2,23										;; imm0 = xmm2

								movaps xmm3,xmmword ptr [int_mantisa]
								pandn xmm3,xmmword ptr [int_one]

								andps xmm0,xmm3
								orps xmm0,xmmword ptr [plus_0p5_ps]

								psubd xmm2,xmmword ptr [int_onetwoseven]
								cvtdq2ps xmm3,xmm2									
								addps xmm3,xmmword ptr [plus_1_ps]					;; e = xmm3

								movaps xmm4,xmm0
								cmpps xmm4,xmmword ptr [sqrthf_ps],01h				;; mask = xmm4
								movaps xmm5,xmm0
								andps xmm5,xmm4										;; tmp = xmm5

								subps xmm0,xmmword ptr [plus_1_ps]
								andps xmm4,xmmword ptr [plus_1_ps]
								subps xmm3,xmm4
								addps xmm0,xmm5

								movaps xmm2,xmm0
								mulps xmm2,xmm2										;; z = xmm2
								movaps xmm4,xmmword ptr [m_lcoef_ps]				;; y = xmm4

								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 16]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 32]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 48]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 64]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 80]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 96]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 112]
								mulps xmm4,xmm0
								addps xmm4,xmmword ptr [m_lcoef_ps + 128]
								mulps xmm4,xmm0
								mulps xmm4,xmm2

								movaps xmm5,xmm3
								mulps xmm5,xmmword ptr [log_q1_ps]
								addps xmm4,xmm5

								movaps xmm5,xmm2
								mulps xmm5,xmmword ptr [plus_0p5_ps]
								subps xmm4,xmm5

								movaps xmm5,xmm3
								mulps xmm5,xmmword ptr [log_q2_ps]
								addps xmm0,xmm4
								addps xmm0,xmm5
								orps xmm0,xmm1
								mulps xmm0,xmmword ptr [minus_2_ps]
								sqrtps xmm0,xmm0									;; x = xmm0

								movaps xmm2,xmm0
								mulps xmm2,xmmword ptr [m_rcoef_ps + 32]
								addps xmm2,xmmword ptr [m_rcoef_ps + 16]
								mulps xmm2,xmm0
								addps xmm2,xmmword ptr [m_rcoef_ps]

								movaps xmm3,xmm0
								mulps xmm3,xmmword ptr [m_rcoef_ps + 80]
								addps xmm3,xmmword ptr [m_rcoef_ps + 64]
								mulps xmm3,xmm0
								addps xmm3,xmmword ptr [m_rcoef_ps + 48]
								mulps xmm3,xmm0
								addps xmm3,xmmword ptr [plus_1_ps]
								divps xmm2,xmm3
								subps xmm0,xmm2
								mulps xmm0,xmm6

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
norm_inv_cdf_sse_ps				endp


;;			extern "C" bool norm_inv_cdf_sse_pd(double const* x, int n, double* out);
;;														rcx,		rdx,		r8
norm_inv_cdf_sse_pd				proc uses rbx

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


					   @@:		movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmm0
								xorpd xmm5,xmm5
								cmplepd xmm1,xmm5									;; neg_mask = xmm1


								movapd xmm7,xmm0
								cmppd xmm7,xmmword ptr [plus_0p5_pd],06h
								andpd xmm7,xmmword ptr [plus_1_pd]					;; ind = xmm7

								movapd xmm6,xmm0
								cmppd xmm6,xmmword ptr [plus_0p5_pd],06h
								andpd xmm6,xmmword ptr [plus_2_pd]
								subpd xmm6,xmmword ptr [plus_1_pd]					;; inv = xmm6	

								maxpd xmm0,xmmword ptr [int_min_norm_pd]			;; x = xmm0
								subpd xmm7,xmm0
								andpd xmm7,xmmword ptr [int_double_abs_mask_pd]
								movapd xmm0,xmm7

								xorpd xmm7,xmm7
								movdqa xmm7,xmmword ptr [qint_twentyfourseven]
								psllq xmm7,52

								movdqa xmm2,xmm7
								pand xmm2,xmm0
								psrlq xmm2,52										;; exps64 = xmm2
								movdqa xmm3,xmmword ptr [int_sixfourtwozero]		;; gTo32bitExp = xmm3

								vpermilps xmm3,xmm2,xmm3							
								movdqa xmm4,xmmword ptr [int_tentwothree]
								psubd xmm3,xmm4
								cvtdq2pd xmm3,xmm3									;; expsPD = xmm3

								movapd xmm5,xmm7
								movapd xmm7,xmm6									;; inv = xmm7
								andnpd xmm5,xmm0

								xorpd xmm6,xmm6
								movdqa xmm6,xmmword ptr [qint_tentwothree]
								psllq xmm6,52
								orpd xmm5,xmm6										;; y = xmm5

								movapd xmm2,xmm5
								subpd xmm5,xmmword ptr [one_pd]
								addpd xmm2,xmmword ptr [one_pd]

								divpd xmm5,xmm2										;; t = xmm5
								movapd xmm2,xmm5
								mulpd xmm2,xmm2										;; t2 = xmm2

								movapd xmm4,xmm5
								mulpd xmm4,xmm2										;; t3 = xmm4
								movapd xmm0,xmmword ptr [m_lcoef_pd]
								vfmadd213pd xmm0,xmm4,xmm5							
								movapd xmm5,xmm0									;; terms01 = xmm5
								mulpd xmm4,xmm2										;; t5 = xmm4

								movapd xmm0,xmmword ptr [m_lcoef_pd + 16]
								vfmadd213pd xmm0,xmm4,xmm5							
								movapd xmm5,xmm0									;; terms012 = xmm5
								mulpd xmm4,xmm2										;; t7 = xmm4

								movapd xmm0,xmmword ptr [m_lcoef_pd + 32]
								vfmadd213pd xmm0,xmm4,xmm5
								movapd xmm5,xmm0									;; terms0123 = xmm5
								mulpd xmm4,xmm2										;; t9 = xmm4

								movapd xmm0,xmmword ptr [m_lcoef_pd + 48]
								vfmadd213pd xmm0,xmm4,xmm5
								movapd xmm5,xmm0									;; terms01234 = xmm5

								mulpd xmm5,xmmword ptr [sqrthf_pd]
								addpd xmm5,xmm3
								divpd xmm5,xmmword ptr [log_q_pd]
								orpd xmm5,xmm1

								mulpd xmm5,xmmword ptr [minus_2_pd]
								sqrtpd xmm5,xmm5

								movapd xmm2,xmm5
								mulpd xmm2,xmmword ptr [m_rcoef_pd + 32]
								addpd xmm2,xmmword ptr [m_rcoef_pd + 16]
								mulpd xmm2,xmm5
								addpd xmm2,xmmword ptr [m_rcoef_pd]

								movapd xmm3,xmm5
								mulpd xmm3,xmmword ptr [m_rcoef_pd + 80]
								addpd xmm3,xmmword ptr [m_rcoef_pd + 64]
								mulpd xmm3,xmm5
								addpd xmm3,xmmword ptr [m_rcoef_pd + 48]
								mulpd xmm3,xmm5
								addpd xmm3,xmmword ptr [plus_1_pd]
								divpd xmm2,xmm3
								subpd xmm5,xmm2
								mulpd xmm5,xmm7

								movapd xmmword ptr [r8],xmm5

								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done
								
								movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmm0
								xorpd xmm5,xmm5
								cmplepd xmm1,xmm5									;; neg_mask = xmm1


								movapd xmm7,xmm0
								cmppd xmm7,xmmword ptr [plus_0p5_pd],06h
								andpd xmm7,xmmword ptr [plus_1_pd]					;; ind = xmm7

								movapd xmm6,xmm0
								cmppd xmm6,xmmword ptr [plus_0p5_pd],06h
								andpd xmm6,xmmword ptr [plus_2_pd]
								subpd xmm6,xmmword ptr [plus_1_pd]					;; inv = xmm6	

								maxpd xmm0,xmmword ptr [int_min_norm_pd]			;; x = xmm0
								subpd xmm7,xmm0
								andpd xmm7,xmmword ptr [int_double_abs_mask_pd]
								movapd xmm0,xmm7

								xorpd xmm7,xmm7
								movdqa xmm7,xmmword ptr [qint_twentyfourseven]
								psllq xmm7,52

								movdqa xmm2,xmm7
								pand xmm2,xmm0
								psrlq xmm2,52										;; exps64 = xmm2
								movdqa xmm3,xmmword ptr [int_sixfourtwozero]		;; gTo32bitExp = xmm3

								vpermilps xmm3,xmm2,xmm3							
								movdqa xmm4,xmmword ptr [int_tentwothree]
								psubd xmm3,xmm4
								cvtdq2pd xmm3,xmm3									;; expsPD = xmm3

								movapd xmm5,xmm7
								movapd xmm7,xmm6									;; inv = xmm7
								andnpd xmm5,xmm0

								xorpd xmm6,xmm6
								movdqa xmm6,xmmword ptr [qint_tentwothree]
								psllq xmm6,52
								orpd xmm5,xmm6										;; y = xmm5

								movapd xmm2,xmm5
								subpd xmm5,xmmword ptr [one_pd]
								addpd xmm2,xmmword ptr [one_pd]

								divpd xmm5,xmm2										;; t = xmm5
								movapd xmm2,xmm5
								mulpd xmm2,xmm2										;; t2 = xmm2

								movapd xmm4,xmm5
								mulpd xmm4,xmm2										;; t3 = xmm4
								movapd xmm0,xmmword ptr [m_lcoef_pd]
								vfmadd213pd xmm0,xmm4,xmm5							
								movapd xmm5,xmm0									;; terms01 = xmm5
								mulpd xmm4,xmm2										;; t5 = xmm4

								movapd xmm0,xmmword ptr [m_lcoef_pd + 16]
								vfmadd213pd xmm0,xmm4,xmm5							
								movapd xmm5,xmm0									;; terms012 = xmm5
								mulpd xmm4,xmm2										;; t7 = xmm4

								movapd xmm0,xmmword ptr [m_lcoef_pd + 32]
								vfmadd213pd xmm0,xmm4,xmm5
								movapd xmm5,xmm0									;; terms0123 = xmm5
								mulpd xmm4,xmm2										;; t9 = xmm4

								movapd xmm0,xmmword ptr [m_lcoef_pd + 48]
								vfmadd213pd xmm0,xmm4,xmm5
								movapd xmm5,xmm0									;; terms01234 = xmm5

								mulpd xmm5,xmmword ptr [sqrthf_pd]
								addpd xmm5,xmm3
								divpd xmm5,xmmword ptr [log_q_pd]
								orpd xmm5,xmm1

								mulpd xmm5,xmmword ptr [minus_2_pd]
								sqrtpd xmm5,xmm5

								movapd xmm2,xmm5
								mulpd xmm2,xmmword ptr [m_rcoef_pd + 32]
								addpd xmm2,xmmword ptr [m_rcoef_pd + 16]
								mulpd xmm2,xmm5
								addpd xmm2,xmmword ptr [m_rcoef_pd]

								movapd xmm3,xmm5
								mulpd xmm3,xmmword ptr [m_rcoef_pd + 80]
								addpd xmm3,xmmword ptr [m_rcoef_pd + 64]
								mulpd xmm3,xmm5
								addpd xmm3,xmmword ptr [m_rcoef_pd + 48]
								mulpd xmm3,xmm5
								addpd xmm3,xmmword ptr [plus_1_pd]
								divpd xmm2,xmm3
								subpd xmm5,xmm2
								mulpd xmm5,xmm7

								movsd real8 ptr [r8],xmm5

					done:		ret
norm_inv_cdf_sse_pd				endp


;;			extern "C" bool norm_cdf_sse_pd(double const* x, int n, double* out);
;;														rcx,	rdx,		r8
norm_cdf_sse_pd				proc uses rbx

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

				 @@:		movapd xmm0,xmmword ptr [rbx]						;; x = xmm0
				 
							xorpd xmm3,xmm3
							movapd xmm5,xmm0
							cmppd xmm5,xmm3,1h
							andpd xmm5,xmmword ptr [plus_1_pd]						;; ind = xmm5
								
							andpd xmm0,xmmword ptr [int_double_abs_mask_pd]
							movapd xmm2,xmm0									;; x = xmm2
							mulpd xmm0,xmm0										;; x*x = xmm0

							movapd xmm3,xmm0
							addpd xmm3,xmmword ptr [poly_pd + 48]
							sqrtpd xmm3,xmm3
							mulpd xmm3,xmmword ptr [poly_pd + 32]
							movapd xmm1,xmm2
							mulpd xmm1,xmmword ptr [poly_pd + 16]
							addpd xmm3,xmm1
							addpd xmm3,xmmword ptr [poly_pd]					;; div = xmm3 

							mulpd xmm0,xmmword ptr[minus_0p5_pd]				;; x*x = xmm0 
							movapd xmm1,xmmword ptr [log2e_pd]
							mulpd xmm1,xmm0										;; a = xmm1
							movapd xmm2,xmm1									;; a = xmm2
							xorpd xmm7,xmm7
							cmpltpd xmm2, xmm7
							movapd xmm6,xmmword ptr [plus_1_pd]
							andpd xmm2,xmm6										;; p = xmm2
							subpd xmm1,xmm2										;; a = xmm1
							cvttpd2dq xmm7, xmm1								;; k = xmm7
							cvtdq2pd xmm2, xmm7									;; p = xmm2


							movapd xmm1,xmmword ptr [c1_pd]
							movapd xmm4,xmmword ptr [c2_pd]
							movapd xmm6,xmm2

							mulpd xmm6,xmm1										;; a = xmm6
							subpd xmm0,xmm6										;; x = xmm0
							movapd xmm6,xmm2

							mulpd xmm6,xmm4										;; a = xmm6
							subpd xmm0,xmm6										;; x = xmm0
								
							movapd xmm1,xmmword ptr [m_ecoef_pd]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 16]
							movapd xmm6,xmm0
							mulpd xmm6,xmm1
							addpd xmm6,xmm4										;; a = xmm6

							movapd xmm1,xmmword ptr [m_ecoef_pd + 32]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 48]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							movapd xmm1,xmmword ptr [m_ecoef_pd + 64]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 80]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							movapd xmm1,xmmword ptr [m_ecoef_pd + 96]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 112]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							movapd xmm1,xmmword ptr [m_ecoef_pd + 128]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 144]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							movapd xmm1,xmmword ptr [m_ecoef_pd + 160]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 176]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							paddd xmm7,xmmword ptr [int_tentwothree]
							pslld xmm7,20
							pshufd xmm7, xmm7, 01110010b
							mulpd xmm6,xmm7

							divpd xmm6,xmm3
							mulpd xmm6,xmmword ptr [one_o_sqrttwopi_pd]
							movapd xmm4,xmmword ptr [plus_1_pd]
							subpd xmm4,xmm6
							subpd xmm5,xmm4
							andps xmm5,xmmword ptr [int_double_abs_mask_pd]

							movapd xmmword ptr [r8],xmm5
							
							add rbx,16
							add r8,16
							dec rcx
							jnz @B

							mov rcx,rax
			too_short:		or rcx,rcx	
							mov rax,1
							jz done

							movapd xmm0,xmmword ptr [rbx]						;; x = xmm0
				 
							xorpd xmm3,xmm3
							movapd xmm5,xmm0
							cmppd xmm5,xmm3,1h
							andpd xmm5,xmmword ptr [plus_1_pd]						;; ind = xmm5
								
							andpd xmm0,xmmword ptr [int_double_abs_mask_pd]
							movapd xmm2,xmm0									;; x = xmm2
							mulpd xmm0,xmm0										;; x*x = xmm0

							movapd xmm3,xmm0
							addpd xmm3,xmmword ptr [poly_pd + 48]
							sqrtpd xmm3,xmm3
							mulpd xmm3,xmmword ptr [poly_pd + 32]
							movapd xmm1,xmm2
							mulpd xmm1,xmmword ptr [poly_pd + 16]
							addpd xmm3,xmm1
							addpd xmm3,xmmword ptr [poly_pd]					;; div = xmm3 

							mulpd xmm0,xmmword ptr[minus_0p5_pd]				;; x*x = xmm0 
							movapd xmm1,xmmword ptr [log2e_pd]
							mulpd xmm1,xmm0										;; a = xmm1
							movapd xmm2,xmm1									;; a = xmm2
							xorpd xmm7,xmm7
							cmpltpd xmm2, xmm7
							movapd xmm6,xmmword ptr [plus_1_pd]
							andpd xmm2,xmm6										;; p = xmm2
							subpd xmm1,xmm2										;; a = xmm1
							cvttpd2dq xmm7, xmm1								;; k = xmm7
							cvtdq2pd xmm2, xmm7									;; p = xmm2


							movapd xmm1,xmmword ptr [c1_pd]
							movapd xmm4,xmmword ptr [c2_pd]
							movapd xmm6,xmm2

							mulpd xmm6,xmm1										;; a = xmm6
							subpd xmm0,xmm6										;; x = xmm0
							movapd xmm6,xmm2

							mulpd xmm6,xmm4										;; a = xmm6
							subpd xmm0,xmm6										;; x = xmm0
								
							movapd xmm1,xmmword ptr [m_ecoef_pd]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 16]
							movapd xmm6,xmm0
							mulpd xmm6,xmm1
							addpd xmm6,xmm4										;; a = xmm6

							movapd xmm1,xmmword ptr [m_ecoef_pd + 32]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 48]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							movapd xmm1,xmmword ptr [m_ecoef_pd + 64]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 80]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							movapd xmm1,xmmword ptr [m_ecoef_pd + 96]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 112]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							movapd xmm1,xmmword ptr [m_ecoef_pd + 128]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 144]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							movapd xmm1,xmmword ptr [m_ecoef_pd + 160]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 176]
							mulpd xmm6,xmm0
							addpd xmm6,xmm1
							mulpd xmm6,xmm0
							addpd xmm6,xmm4										;; a = xmm6	

							paddd xmm7,xmmword ptr [int_tentwothree]
							pslld xmm7,20
							pshufd xmm7, xmm7, 01110010b
							mulpd xmm6,xmm7

							divpd xmm6,xmm3
							mulpd xmm6,xmmword ptr [one_o_sqrttwopi_pd]
							movapd xmm4,xmmword ptr [plus_1_pd]
							subpd xmm4,xmm6
							subpd xmm5,xmm4
							andps xmm5,xmmword ptr [int_double_abs_mask_pd]

							movsd real8 ptr [r8],xmm5

				done:		ret
norm_cdf_sse_pd				endp

;;		extern "C" bool norm_cdf_sse_ps(float const* x, int n, float* out);
;;												rcx,		rdx,		r8
norm_cdf_sse_ps				proc uses rbx

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

							xorps xmm7,xmm7

				  @@:		movaps xmm0,xmmword ptr [rbx]						;; x = xmm0

							movaps xmm6,xmm0
							cmpltps xmm6,xmm7								
							cvtdq2ps xmm6,xmm6									;; ind = xmm6
							andps xmm6,xmmword ptr [int_float_abs_mask_ps]		;; x = xmm0
							andps xmm0,xmmword ptr [int_float_abs_mask_ps]
							movaps xmm1,xmm0
							mulps xmm1,xmm1										;; x*x = xmm1

							movaps xmm5,xmmword ptr [poly_ps + 48]
							addps xmm5,xmm1
							sqrtps xmm5,xmm5
							mulps xmm5,xmmword ptr [poly_ps + 32]
							addps xmm5,xmmword ptr [poly_ps]
							movaps xmm3,xmm0
							mulps xmm3,xmmword ptr [poly_ps + 16]
							addps xmm5,xmm3

							movaps xmm0,xmm1
							mulps xmm0,xmmword ptr [minus_0p5_ps]

							movaps xmm1,xmm0							
							mulps xmm1,xmmword ptr [log2e_ps]			
							addps xmm1,xmmword ptr [plus_0p5_ps]			;; fx = xmm1
							roundps xmm2,xmm1,0001b							;; tmp = xmm2
							movaps xmm3,xmm2
							cmpps xmm3,xmm1,0eh							
							andps xmm3,xmmword ptr [plus_1_ps]				;; mask = xmm3
							movaps xmm4,xmm2
							subps xmm4,xmm3									;; fx = xmm4
							movaps xmm1,xmm4
							mulps xmm1,xmmword ptr [c1_ps]					;; tmp = xmm1
							movaps xmm2,xmm4
							mulps xmm2,xmmword ptr [c2_ps]					;; z = xmm2
							subps xmm0,xmm1									;; x = xmm0
							subps xmm0,xmm2
							movaps xmm2,xmm0
							mulps xmm2,xmm2									;; z = xmm2

							movaps xmm1,xmmword ptr [m_ecoef_ps]			;; y = xmm1
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

							divps xmm3,xmm5
							mulps xmm3,xmmword ptr [one_o_sqrttwopi_ps]
							movaps xmm4,xmmword ptr [plus_1_ps]
							subps xmm4,xmm3
							subps xmm6,xmm4
							andps xmm6,xmmword ptr [int_float_abs_mask_ps]
							movaps xmmword ptr [r8],xmm6
							
							add rbx,16
							add r8,16
							dec rcx
							jnz @B

							mov rcx,rax
			too_short:		or rcx,rcx
							mov rax,1
							jz done

							movaps xmm0,xmmword ptr [rbx]						;; x = xmm0
							movaps xmm6,xmm0
							cmpltps xmm6,xmm7								
							cvtdq2ps xmm6,xmm6									;; ind = xmm6
							andps xmm6,xmmword ptr [int_float_abs_mask_ps]		;; x = xmm0
							andps xmm0,xmmword ptr [int_float_abs_mask_ps]
							movaps xmm1,xmm0
							mulps xmm1,xmm1										;; x*x = xmm1

							movaps xmm5,xmmword ptr [poly_ps + 48]
							addps xmm5,xmm1
							sqrtps xmm5,xmm5
							mulps xmm5,xmmword ptr [poly_ps + 32]
							addps xmm5,xmmword ptr [poly_ps]
							movaps xmm3,xmm0
							mulps xmm3,xmmword ptr [poly_ps + 16]
							addps xmm5,xmm3

							movaps xmm0,xmm1
							mulps xmm0,xmmword ptr [minus_0p5_ps]

							movaps xmm1,xmm0							
							mulps xmm1,xmmword ptr [log2e_ps]			
							addps xmm1,xmmword ptr [plus_0p5_ps]			;; fx = xmm1
							roundps xmm2,xmm1,0001b							;; tmp = xmm2
							movaps xmm3,xmm2
							cmpps xmm3,xmm1,0eh							
							andps xmm3,xmmword ptr [plus_1_ps]				;; mask = xmm3
							movaps xmm4,xmm2
							subps xmm4,xmm3									;; fx = xmm4
							movaps xmm1,xmm4
							mulps xmm1,xmmword ptr [c1_ps]					;; tmp = xmm1
							movaps xmm2,xmm4
							mulps xmm2,xmmword ptr [c2_ps]					;; z = xmm2
							subps xmm0,xmm1									;; x = xmm0
							subps xmm0,xmm2
							movaps xmm2,xmm0
							mulps xmm2,xmm2									;; z = xmm2

							movaps xmm1,xmmword ptr [m_ecoef_ps]			;; y = xmm1
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

							divps xmm3,xmm5
							mulps xmm3,xmmword ptr [one_o_sqrttwopi_ps]
							movaps xmm4,xmmword ptr [plus_1_ps]
							subps xmm4,xmm3
							subps xmm6,xmm4
							andps xmm6,xmmword ptr [int_float_abs_mask_ps]

							cmp rcx,1
							je short one_left
							cmp rcx,2
							je short two_left
							cmp rcx,3
							je short three_left

			one_left:		movss real4 ptr [r8],xmm6
							jmp short done
			two_left:		insertps xmm2,xmm6,01000000b
							movss real4 ptr [r8],xmm6
							movss real4 ptr [r8 + 4],xmm2	
							jmp short done
			three_left:		insertps xmm2,xmm6,01000000b
							insertps xmm4,xmm6,10000000b
							movss real4 ptr [r8],xmm6
							movss real4 ptr [r8 + 4],xmm2
							movss real4 ptr [r8 + 8],xmm4

				done:		ret
norm_cdf_sse_ps				endp
							end
