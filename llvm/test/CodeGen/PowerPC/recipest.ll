; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc64-unknown-linux-gnu -mcpu=pwr7 -mattr=-vsx | FileCheck %s

target datalayout = "E-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-f128:128:128-v128:128:128-n32:64"
target triple = "powerpc64-unknown-linux-gnu"

declare double @llvm.sqrt.f64(double)
declare float @llvm.sqrt.f32(float)
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>)

define double @foo_fmf(double %a, double %b) nounwind {
; CHECK-LABEL: foo_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    frsqrte 0, 2
; CHECK-NEXT:    addis 3, 2, .LCPI0_0@toc@ha
; CHECK-NEXT:    addis 4, 2, .LCPI0_1@toc@ha
; CHECK-NEXT:    lfs 4, .LCPI0_0@toc@l(3)
; CHECK-NEXT:    lfs 5, .LCPI0_1@toc@l(4)
; CHECK-NEXT:    fmul 3, 2, 0
; CHECK-NEXT:    fmadd 3, 3, 0, 4
; CHECK-NEXT:    fmul 0, 0, 5
; CHECK-NEXT:    fmul 0, 0, 3
; CHECK-NEXT:    fmul 2, 2, 0
; CHECK-NEXT:    fmadd 2, 2, 0, 4
; CHECK-NEXT:    fmul 0, 0, 5
; CHECK-NEXT:    fmul 0, 0, 2
; CHECK-NEXT:    fmul 1, 1, 0
; CHECK-NEXT:    blr
  %x = call fast double @llvm.sqrt.f64(double %b)
  %r = fdiv fast double %a, %x
  ret double %r
}

define double @foo_safe(double %a, double %b) nounwind {
; CHECK-LABEL: foo_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsqrt 0, 2
; CHECK-NEXT:    fdiv 1, 1, 0
; CHECK-NEXT:    blr
  %x = call double @llvm.sqrt.f64(double %b)
  %r = fdiv double %a, %x
  ret double %r
}

define double @no_estimate_refinement_f64(double %a, double %b) #0 {
; CHECK-LABEL: no_estimate_refinement_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    frsqrte 0, 2
; CHECK-NEXT:    fmul 1, 1, 0
; CHECK-NEXT:    blr
  %x = call fast double @llvm.sqrt.f64(double %b)
  %r = fdiv fast double %a, %x
  ret double %r
}

define double @foof_fmf(double %a, float %b) nounwind {
; CHECK-LABEL: foof_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    frsqrtes 0, 2
; CHECK-NEXT:    addis 3, 2, .LCPI3_0@toc@ha
; CHECK-NEXT:    addis 4, 2, .LCPI3_1@toc@ha
; CHECK-NEXT:    lfs 3, .LCPI3_0@toc@l(3)
; CHECK-NEXT:    lfs 4, .LCPI3_1@toc@l(4)
; CHECK-NEXT:    fmuls 2, 2, 0
; CHECK-NEXT:    fmadds 2, 2, 0, 3
; CHECK-NEXT:    fmuls 0, 0, 4
; CHECK-NEXT:    fmuls 0, 0, 2
; CHECK-NEXT:    fmul 1, 1, 0
; CHECK-NEXT:    blr
  %x = call fast float @llvm.sqrt.f32(float %b)
  %y = fpext float %x to double
  %r = fdiv fast double %a, %y
  ret double %r
}

define double @foof_safe(double %a, float %b) nounwind {
; CHECK-LABEL: foof_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsqrts 0, 2
; CHECK-NEXT:    fdiv 1, 1, 0
; CHECK-NEXT:    blr
  %x = call float @llvm.sqrt.f32(float %b)
  %y = fpext float %x to double
  %r = fdiv double %a, %y
  ret double %r
}

define float @food_fmf(float %a, double %b) nounwind {
; CHECK-LABEL: food_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    frsqrte 0, 2
; CHECK-NEXT:    addis 3, 2, .LCPI5_0@toc@ha
; CHECK-NEXT:    addis 4, 2, .LCPI5_1@toc@ha
; CHECK-NEXT:    lfs 4, .LCPI5_0@toc@l(3)
; CHECK-NEXT:    lfs 5, .LCPI5_1@toc@l(4)
; CHECK-NEXT:    fmul 3, 2, 0
; CHECK-NEXT:    fmadd 3, 3, 0, 4
; CHECK-NEXT:    fmul 0, 0, 5
; CHECK-NEXT:    fmul 0, 0, 3
; CHECK-NEXT:    fmul 2, 2, 0
; CHECK-NEXT:    fmadd 2, 2, 0, 4
; CHECK-NEXT:    fmul 0, 0, 5
; CHECK-NEXT:    fmul 0, 0, 2
; CHECK-NEXT:    frsp 0, 0
; CHECK-NEXT:    fmuls 1, 1, 0
; CHECK-NEXT:    blr
  %x = call fast double @llvm.sqrt.f64(double %b)
  %y = fptrunc double %x to float
  %r = fdiv fast float %a, %y
  ret float %r
}

define float @food_safe(float %a, double %b) nounwind {
; CHECK-LABEL: food_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsqrt 0, 2
; CHECK-NEXT:    frsp 0, 0
; CHECK-NEXT:    fdivs 1, 1, 0
; CHECK-NEXT:    blr
  %x = call double @llvm.sqrt.f64(double %b)
  %y = fptrunc double %x to float
  %r = fdiv float %a, %y
  ret float %r
}

define float @goo_fmf(float %a, float %b) nounwind {
; CHECK-LABEL: goo_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    frsqrtes 0, 2
; CHECK-NEXT:    addis 3, 2, .LCPI7_0@toc@ha
; CHECK-NEXT:    addis 4, 2, .LCPI7_1@toc@ha
; CHECK-NEXT:    lfs 3, .LCPI7_0@toc@l(3)
; CHECK-NEXT:    lfs 4, .LCPI7_1@toc@l(4)
; CHECK-NEXT:    fmuls 2, 2, 0
; CHECK-NEXT:    fmadds 2, 2, 0, 3
; CHECK-NEXT:    fmuls 0, 0, 4
; CHECK-NEXT:    fmuls 0, 0, 2
; CHECK-NEXT:    fmuls 1, 1, 0
; CHECK-NEXT:    blr
  %x = call fast float @llvm.sqrt.f32(float %b)
  %r = fdiv fast float %a, %x
  ret float %r
}

define float @goo_safe(float %a, float %b) nounwind {
; CHECK-LABEL: goo_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsqrts 0, 2
; CHECK-NEXT:    fdivs 1, 1, 0
; CHECK-NEXT:    blr
  %x = call float @llvm.sqrt.f32(float %b)
  %r = fdiv float %a, %x
  ret float %r
}

define float @no_estimate_refinement_f32(float %a, float %b) #0 {
; CHECK-LABEL: no_estimate_refinement_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    frsqrtes 0, 2
; CHECK-NEXT:    fmuls 1, 1, 0
; CHECK-NEXT:    blr
  %x = call fast float @llvm.sqrt.f32(float %b)
  %r = fdiv fast float %a, %x
  ret float %r
}

; Recognize that this is rsqrt(a) * rcp(b) * c,
; not 1 / ( 1 / sqrt(a)) * rcp(b) * c.
define float @rsqrt_fmul_fmf(float %a, float %b, float %c) {
; CHECK-LABEL: rsqrt_fmul_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    frsqrtes 0, 1
; CHECK-NEXT:    addis 3, 2, .LCPI10_0@toc@ha
; CHECK-NEXT:    addis 4, 2, .LCPI10_1@toc@ha
; CHECK-NEXT:    lfs 4, .LCPI10_0@toc@l(3)
; CHECK-NEXT:    lfs 5, .LCPI10_1@toc@l(4)
; CHECK-NEXT:    fmuls 1, 1, 0
; CHECK-NEXT:    fmadds 1, 1, 0, 4
; CHECK-NEXT:    fmuls 0, 0, 5
; CHECK-NEXT:    fmuls 0, 0, 1
; CHECK-NEXT:    fres 1, 2
; CHECK-NEXT:    fmuls 4, 0, 1
; CHECK-NEXT:    fnmsubs 0, 2, 4, 0
; CHECK-NEXT:    fmadds 0, 1, 0, 4
; CHECK-NEXT:    fmuls 1, 3, 0
; CHECK-NEXT:    blr
  %x = call fast float @llvm.sqrt.f32(float %a)
  %y = fmul fast float %x, %b
  %z = fdiv fast float %c, %y
  ret float %z
}

; Recognize that this is rsqrt(a) * rcp(b) * c,
; not 1 / ( 1 / sqrt(a)) * rcp(b) * c.
define float @rsqrt_fmul_safe(float %a, float %b, float %c) {
; CHECK-LABEL: rsqrt_fmul_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsqrts 0, 1
; CHECK-NEXT:    fmuls 0, 0, 2
; CHECK-NEXT:    fdivs 1, 3, 0
; CHECK-NEXT:    blr
  %x = call float @llvm.sqrt.f32(float %a)
  %y = fmul float %x, %b
  %z = fdiv float %c, %y
  ret float %z
}

define <4 x float> @hoo_fmf(<4 x float> %a, <4 x float> %b) nounwind {
; CHECK-LABEL: hoo_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vspltisw 4, -1
; CHECK-NEXT:    addis 3, 2, .LCPI12_0@toc@ha
; CHECK-NEXT:    vrsqrtefp 5, 3
; CHECK-NEXT:    addi 3, 3, .LCPI12_0@toc@l
; CHECK-NEXT:    lvx 0, 0, 3
; CHECK-NEXT:    addis 3, 2, .LCPI12_1@toc@ha
; CHECK-NEXT:    addi 3, 3, .LCPI12_1@toc@l
; CHECK-NEXT:    lvx 1, 0, 3
; CHECK-NEXT:    vslw 4, 4, 4
; CHECK-NEXT:    vmaddfp 3, 3, 5, 4
; CHECK-NEXT:    vmaddfp 3, 3, 5, 0
; CHECK-NEXT:    vmaddfp 5, 5, 1, 4
; CHECK-NEXT:    vmaddfp 3, 5, 3, 4
; CHECK-NEXT:    vmaddfp 2, 2, 3, 4
; CHECK-NEXT:    blr
  %x = call fast <4 x float> @llvm.sqrt.v4f32(<4 x float> %b)
  %r = fdiv fast <4 x float> %a, %x
  ret <4 x float> %r
}

define <4 x float> @hoo_safe(<4 x float> %a, <4 x float> %b) nounwind {
; CHECK-LABEL: hoo_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi 3, 1, -32
; CHECK-NEXT:    stvx 3, 0, 3
; CHECK-NEXT:    addi 3, 1, -48
; CHECK-NEXT:    lfs 0, -20(1)
; CHECK-NEXT:    lfs 3, -24(1)
; CHECK-NEXT:    lfs 1, -32(1)
; CHECK-NEXT:    lfs 2, -28(1)
; CHECK-NEXT:    stvx 2, 0, 3
; CHECK-NEXT:    addi 3, 1, -16
; CHECK-NEXT:    fsqrts 0, 0
; CHECK-NEXT:    lfs 4, -36(1)
; CHECK-NEXT:    fsqrts 3, 3
; CHECK-NEXT:    fsqrts 2, 2
; CHECK-NEXT:    fsqrts 1, 1
; CHECK-NEXT:    fdivs 0, 4, 0
; CHECK-NEXT:    stfs 0, -4(1)
; CHECK-NEXT:    lfs 0, -40(1)
; CHECK-NEXT:    fdivs 0, 0, 3
; CHECK-NEXT:    stfs 0, -8(1)
; CHECK-NEXT:    lfs 0, -44(1)
; CHECK-NEXT:    fdivs 0, 0, 2
; CHECK-NEXT:    stfs 0, -12(1)
; CHECK-NEXT:    lfs 0, -48(1)
; CHECK-NEXT:    fdivs 0, 0, 1
; CHECK-NEXT:    stfs 0, -16(1)
; CHECK-NEXT:    lvx 2, 0, 3
; CHECK-NEXT:    blr
  %x = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %b)
  %r = fdiv <4 x float> %a, %x
  ret <4 x float> %r
}

define double @foo2_fmf(double %a, double %b) nounwind {
; CHECK-LABEL: foo2_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fre 0, 2
; CHECK-NEXT:    addis 3, 2, .LCPI14_0@toc@ha
; CHECK-NEXT:    lfs 3, .LCPI14_0@toc@l(3)
; CHECK-NEXT:    fmadd 3, 2, 0, 3
; CHECK-NEXT:    fnmsub 0, 0, 3, 0
; CHECK-NEXT:    fmul 3, 1, 0
; CHECK-NEXT:    fnmsub 1, 2, 3, 1
; CHECK-NEXT:    fmadd 1, 0, 1, 3
; CHECK-NEXT:    blr
  %r = fdiv fast double %a, %b
  ret double %r
}

define double @foo2_safe(double %a, double %b) nounwind {
; CHECK-LABEL: foo2_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv 1, 1, 2
; CHECK-NEXT:    blr
  %r = fdiv double %a, %b
  ret double %r
}

define float @goo2_fmf(float %a, float %b) nounwind {
; CHECK-LABEL: goo2_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fres 0, 2
; CHECK-NEXT:    fmuls 3, 1, 0
; CHECK-NEXT:    fnmsubs 1, 2, 3, 1
; CHECK-NEXT:    fmadds 1, 0, 1, 3
; CHECK-NEXT:    blr
  %r = fdiv fast float %a, %b
  ret float %r
}

define float @goo2_safe(float %a, float %b) nounwind {
; CHECK-LABEL: goo2_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdivs 1, 1, 2
; CHECK-NEXT:    blr
  %r = fdiv float %a, %b
  ret float %r
}

define <4 x float> @hoo2_fmf(<4 x float> %a, <4 x float> %b) nounwind {
; CHECK-LABEL: hoo2_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vspltisw 4, -1
; CHECK-NEXT:    vrefp 5, 3
; CHECK-NEXT:    vspltisb 0, -1
; CHECK-NEXT:    vslw 0, 0, 0
; CHECK-NEXT:    vslw 4, 4, 4
; CHECK-NEXT:    vsubfp 3, 0, 3
; CHECK-NEXT:    vmaddfp 4, 2, 5, 4
; CHECK-NEXT:    vmaddfp 2, 3, 4, 2
; CHECK-NEXT:    vmaddfp 2, 5, 2, 4
; CHECK-NEXT:    blr
  %r = fdiv fast <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @hoo2_safe(<4 x float> %a, <4 x float> %b) nounwind {
; CHECK-LABEL: hoo2_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi 3, 1, -32
; CHECK-NEXT:    addi 4, 1, -48
; CHECK-NEXT:    stvx 3, 0, 3
; CHECK-NEXT:    stvx 2, 0, 4
; CHECK-NEXT:    lfs 0, -20(1)
; CHECK-NEXT:    lfs 1, -36(1)
; CHECK-NEXT:    addi 3, 1, -16
; CHECK-NEXT:    fdivs 0, 1, 0
; CHECK-NEXT:    lfs 1, -40(1)
; CHECK-NEXT:    stfs 0, -4(1)
; CHECK-NEXT:    lfs 0, -24(1)
; CHECK-NEXT:    fdivs 0, 1, 0
; CHECK-NEXT:    lfs 1, -44(1)
; CHECK-NEXT:    stfs 0, -8(1)
; CHECK-NEXT:    lfs 0, -28(1)
; CHECK-NEXT:    fdivs 0, 1, 0
; CHECK-NEXT:    lfs 1, -48(1)
; CHECK-NEXT:    stfs 0, -12(1)
; CHECK-NEXT:    lfs 0, -32(1)
; CHECK-NEXT:    fdivs 0, 1, 0
; CHECK-NEXT:    stfs 0, -16(1)
; CHECK-NEXT:    lvx 2, 0, 3
; CHECK-NEXT:    blr
  %r = fdiv <4 x float> %a, %b
  ret <4 x float> %r
}

define double @foo3_fmf(double %a) nounwind {
; CHECK-LABEL: foo3_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fabs 0, 1
; CHECK-NEXT:    addis 3, 2, .LCPI20_2@toc@ha
; CHECK-NEXT:    lfd 2, .LCPI20_2@toc@l(3)
; CHECK-NEXT:    fcmpu 0, 0, 2
; CHECK-NEXT:    blt 0, .LBB20_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    frsqrte 0, 1
; CHECK-NEXT:    addis 3, 2, .LCPI20_0@toc@ha
; CHECK-NEXT:    addis 4, 2, .LCPI20_1@toc@ha
; CHECK-NEXT:    lfs 3, .LCPI20_0@toc@l(3)
; CHECK-NEXT:    lfs 4, .LCPI20_1@toc@l(4)
; CHECK-NEXT:    fmul 2, 1, 0
; CHECK-NEXT:    fmadd 2, 2, 0, 3
; CHECK-NEXT:    fmul 0, 0, 4
; CHECK-NEXT:    fmul 0, 0, 2
; CHECK-NEXT:    fmul 1, 1, 0
; CHECK-NEXT:    fmadd 0, 1, 0, 3
; CHECK-NEXT:    fmul 1, 1, 4
; CHECK-NEXT:    fmul 1, 1, 0
; CHECK-NEXT:    blr
; CHECK-NEXT:  .LBB20_2:
; CHECK-NEXT:    addis 3, 2, .LCPI20_3@toc@ha
; CHECK-NEXT:    lfs 1, .LCPI20_3@toc@l(3)
; CHECK-NEXT:    blr
  %r = call fast double @llvm.sqrt.f64(double %a)
  ret double %r
}

define double @foo3_safe(double %a) nounwind {
; CHECK-LABEL: foo3_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsqrt 1, 1
; CHECK-NEXT:    blr
  %r = call double @llvm.sqrt.f64(double %a)
  ret double %r
}

define float @goo3_fmf(float %a) nounwind {
; CHECK-LABEL: goo3_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fabs 0, 1
; CHECK-NEXT:    addis 3, 2, .LCPI22_2@toc@ha
; CHECK-NEXT:    lfs 2, .LCPI22_2@toc@l(3)
; CHECK-NEXT:    fcmpu 0, 0, 2
; CHECK-NEXT:    blt 0, .LBB22_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    frsqrtes 0, 1
; CHECK-NEXT:    addis 3, 2, .LCPI22_0@toc@ha
; CHECK-NEXT:    addis 4, 2, .LCPI22_1@toc@ha
; CHECK-NEXT:    lfs 2, .LCPI22_0@toc@l(3)
; CHECK-NEXT:    lfs 3, .LCPI22_1@toc@l(4)
; CHECK-NEXT:    fmuls 1, 1, 0
; CHECK-NEXT:    fmadds 0, 1, 0, 2
; CHECK-NEXT:    fmuls 1, 1, 3
; CHECK-NEXT:    fmuls 1, 1, 0
; CHECK-NEXT:    blr
; CHECK-NEXT:  .LBB22_2:
; CHECK-NEXT:    addis 3, 2, .LCPI22_3@toc@ha
; CHECK-NEXT:    lfs 1, .LCPI22_3@toc@l(3)
; CHECK-NEXT:    blr
  %r = call fast float @llvm.sqrt.f32(float %a)
  ret float %r
}

define float @goo3_safe(float %a) nounwind {
; CHECK-LABEL: goo3_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsqrts 1, 1
; CHECK-NEXT:    blr
  %r = call float @llvm.sqrt.f32(float %a)
  ret float %r
}

define <4 x float> @hoo3_fmf(<4 x float> %a) #1 {
; CHECK-LABEL: hoo3_fmf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vspltisw 3, -1
; CHECK-NEXT:    addis 3, 2, .LCPI24_0@toc@ha
; CHECK-NEXT:    vrsqrtefp 4, 2
; CHECK-NEXT:    addi 3, 3, .LCPI24_0@toc@l
; CHECK-NEXT:    lvx 0, 0, 3
; CHECK-NEXT:    addis 3, 2, .LCPI24_1@toc@ha
; CHECK-NEXT:    addi 3, 3, .LCPI24_1@toc@l
; CHECK-NEXT:    lvx 1, 0, 3
; CHECK-NEXT:    vslw 3, 3, 3
; CHECK-NEXT:    vmaddfp 5, 2, 4, 3
; CHECK-NEXT:    vmaddfp 4, 5, 4, 0
; CHECK-NEXT:    vmaddfp 5, 5, 1, 3
; CHECK-NEXT:    vxor 0, 0, 0
; CHECK-NEXT:    vmaddfp 3, 5, 4, 3
; CHECK-NEXT:    vcmpeqfp 2, 2, 0
; CHECK-NEXT:    vsel 2, 3, 0, 2
; CHECK-NEXT:    blr
  %r = call fast <4 x float> @llvm.sqrt.v4f32(<4 x float> %a)
  ret <4 x float> %r
}

define <4 x float> @hoo3_safe(<4 x float> %a) nounwind {
; CHECK-LABEL: hoo3_safe:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi 3, 1, -32
; CHECK-NEXT:    stvx 2, 0, 3
; CHECK-NEXT:    addi 3, 1, -16
; CHECK-NEXT:    lfs 0, -20(1)
; CHECK-NEXT:    fsqrts 0, 0
; CHECK-NEXT:    stfs 0, -4(1)
; CHECK-NEXT:    lfs 0, -24(1)
; CHECK-NEXT:    fsqrts 0, 0
; CHECK-NEXT:    stfs 0, -8(1)
; CHECK-NEXT:    lfs 0, -28(1)
; CHECK-NEXT:    fsqrts 0, 0
; CHECK-NEXT:    stfs 0, -12(1)
; CHECK-NEXT:    lfs 0, -32(1)
; CHECK-NEXT:    fsqrts 0, 0
; CHECK-NEXT:    stfs 0, -16(1)
; CHECK-NEXT:    lvx 2, 0, 3
; CHECK-NEXT:    blr
  %r = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %a)
  ret <4 x float> %r
}

attributes #0 = { nounwind "reciprocal-estimates"="sqrtf:0,sqrtd:0" }
attributes #1 = { nounwind "denormal-fp-math"="preserve-sign,preserve-sign" }
