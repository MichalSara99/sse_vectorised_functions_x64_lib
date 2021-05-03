;; ============================= CONSTANTS =================================
.const 
align 16	
abs_mask_ps					dword	7fffffffh,7fffffffh,7fffffffh,7fffffffh	
abs_mask_pd					qword	7fffffffffffffffh,7fffffffffffffffh

;; ============================ PROTOTYPES =================================

maxs_sse_ps proto
maxs_sse_pd proto
mins_sse_ps proto
mins_sse_pd proto
abs_sse_ps proto
abs_sse_pd proto
sqrt_sse_ps proto
sqrt_sse_pd proto
sqrpow_sse_ps proto
sqrpow_sse_pd proto

