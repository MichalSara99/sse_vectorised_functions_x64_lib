
.const
align 16
;; =============== packed double precision floating point =================

plus_1_pd						real8	1.0,1.0
;; =============== packed single precision floating point =================

plus_1_ps						real4	1.0,1.0,1.0,1.0
;; ============================== GENERAL =================================

int_neg_mask_ps					dword	80000000h,80000000h,80000000h,80000000h
int_neg_mask_pd					qword	8000000000000000h,8000000000000000h

;; ============================ PROTOTYPES =================================

;; broadcast versions:
mul_br_sse_pd proto
mul_br_sse_ps proto
div_br_sse_ps proto
div_br_sse_pd proto
div_br_s_sse_ps proto
div_br_s_sse_pd proto
add_br_sse_ps proto
add_br_sse_pd proto
sub_br_sse_ps proto
sub_br_sse_pd proto
sub_br_s_sse_ps proto
sub_br_s_sse_pd proto

;; non-broadcast versions:
mul_sse_ps proto
mul_sse_pd proto
div_sse_ps proto
div_sse_pd proto
add_sse_ps proto
add_sse_pd proto
sub_sse_ps proto
sub_sse_pd proto
neg_sse_pd proto
neg_sse_ps proto
inv_sse_pd proto
inv_sse_ps proto