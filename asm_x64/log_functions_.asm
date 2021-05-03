include asm_x64_incs/log_functions.inc

								.code
;;			extern "C" bool log_sse_ps(float const* in_aligned_16, int n, float* out_aligned_16);
;;															rcx,	rdx,					r8
log_sse_ps						proc uses rbx

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
								movaps xmm1,xmm0
								cmpps xmm1,xmm7,02h									;; inval_mask = xmm1
								
								maxps xmm0,xmmword ptr [int_min_norm]				;; x = xmm0
								movaps xmm2,xmm0									
								psrld xmm2,23										;; imm0 = xmm2

								movaps xmm3,xmmword ptr [int_mantisa]
								pandn xmm3,xmmword ptr [int_one]

								andps xmm0,xmm3
								orps xmm0,xmmword ptr [one_half_ps]

								psubd xmm2,xmmword ptr [int_onetwoseven]
								cvtdq2ps xmm3,xmm2									
								addps xmm3,xmmword ptr [one_ps]						;; e = xmm3

								movaps xmm4,xmm0
								cmpps xmm4,xmmword ptr [sqrthf_ps],01h				;; mask = xmm4
								movaps xmm5,xmm0
								andps xmm5,xmm4										;; tmp = xmm5

								subps xmm0,xmmword ptr [one_ps]
								andps xmm4,xmmword ptr [one_ps]
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
								mulps xmm5,xmmword ptr [one_half_ps]
								subps xmm4,xmm5

								movaps xmm5,xmm3
								mulps xmm5,xmmword ptr [log_q2_ps]
								addps xmm0,xmm4
								addps xmm0,xmm5
								orps xmm0,xmm1

								movaps xmmword ptr [r8],xmm0

								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
				too_short:		or rcx,rcx
								mov rax,1
								jz done

								xorps xmm7,xmm7
								movaps xmm0,xmmword ptr [rbx]						;; x = xmm0
								movaps xmm1,xmm0
								cmpps xmm1,xmm7,02h									;; inval_mask = xmm1
								
								maxps xmm0,xmmword ptr [int_min_norm]				;; x = xmm0
								movaps xmm2,xmm0									
								psrld xmm2,23										;; imm0 = xmm2

								movaps xmm3,xmmword ptr [int_mantisa]
								pandn xmm3,xmmword ptr [int_one]

								andps xmm0,xmm3
								orps xmm0,xmmword ptr [one_half_ps]

								psubd xmm2,xmmword ptr [int_onetwoseven]
								cvtdq2ps xmm3,xmm2									
								addps xmm3,xmmword ptr [one_ps]						;; e = xmm3

								movaps xmm4,xmm0
								cmpps xmm4,xmmword ptr [sqrthf_ps],01h				;; mask = xmm4
								movaps xmm5,xmm0
								andps xmm5,xmm4										;; tmp = xmm5

								subps xmm0,xmmword ptr [one_ps]
								andps xmm4,xmmword ptr [one_ps]
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
								mulps xmm5,xmmword ptr [one_half_ps]
								subps xmm4,xmm5

								movaps xmm5,xmm3
								mulps xmm5,xmmword ptr [log_q2_ps]
								addps xmm0,xmm4
								addps xmm0,xmm5
								orps xmm0,xmm1

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
log_sse_ps						endp

;;			extern "C" bool log_sse_pd(double const* x, int n, double* out);
;;												rcx,	rdx,			r8	
log_sse_pd						proc uses rbx

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

								xorpd xmm7,xmm7
								xorpd xmm6,xmm6

								movdqa xmm7,xmmword ptr [qint_twentyfourseven]
								psllq xmm7,52
								movdqa xmm6,xmmword ptr [qint_tentwothree]
								psllq xmm6,52

					   @@:		movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmm0

								xorpd xmm5,xmm5
								cmplepd xmm1,xmm5									;; neg_mask = xmm1

								movdqa xmm2,xmm7
								pand xmm2,xmm0
								psrlq xmm2,52										;; exps64 = xmm2
								movdqa xmm3,xmmword ptr [int_sixfourtwozero]		;; gTo32bitExp = xmm3

								vpermilps xmm3,xmm2,xmm3							
								movdqa xmm4,xmmword ptr [int_tentwothree]
								psubd xmm3,xmm4
								cvtdq2pd xmm3,xmm3									;; expsPD = xmm3

								movapd xmm5,xmm7
								andnpd xmm5,xmm0
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

								movapd xmmword ptr [r8],xmm5

								add rbx,16
								add r8,16
								dec rcx
								jnz @B

								mov rcx,rax
			too_short:			or rcx,rcx
								mov rax,1
								jz done

								xorpd xmm7,xmm7
								xorpd xmm6,xmm6

								movdqa xmm7,xmmword ptr [qint_twentyfourseven]
								psllq xmm7,52
								movdqa xmm6,xmmword ptr [qint_tentwothree]
								psllq xmm6,52

								movapd xmm0,xmmword ptr [rbx]
								movapd xmm1,xmm0

								xorpd xmm5,xmm5
								cmplepd xmm1,xmm5									;; neg_mask = xmm1

								movdqa xmm2,xmm7
								pand xmm2,xmm0
								psrlq xmm2,52										;; exps64 = xmm2
								movdqa xmm3,xmmword ptr [int_sixfourtwozero]		;; gTo32bitExp = xmm3

								vpermilps xmm3,xmm2,xmm3							
								movdqa xmm4,xmmword ptr [int_tentwothree]
								psubd xmm3,xmm4
								cvtdq2pd xmm3,xmm3									;; expsPD = xmm3

								movapd xmm5,xmm7
								andnpd xmm5,xmm0
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

								movsd real8 ptr [r8],xmm5

					done:		ret
log_sse_pd						endp
								end