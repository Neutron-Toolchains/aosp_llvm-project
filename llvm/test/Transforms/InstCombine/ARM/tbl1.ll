; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv8-arm-none-eabi"

; Turning a table lookup intrinsic into a shuffle vector instruction
; can be beneficial. If the mask used for the lookup is the constant
; vector {7,6,5,4,3,2,1,0}, then the back-end generates rev64
; instructions instead.

define <8 x i8> @tbl1_8x8(<8 x i8> %vec) {
; CHECK-LABEL: @tbl1_8x8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <8 x i8> [[VEC:%.*]], <8 x i8> poison, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    ret <8 x i8> [[TMP0]]
;
entry:
  %vtbl1 = call <8 x i8> @llvm.arm.neon.vtbl1(<8 x i8> %vec, <8 x i8> <i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0>)
  ret <8 x i8> %vtbl1
}

; Bail the optimization if a mask index is out of range.
define <8 x i8> @tbl1_8x8_out_of_range(<8 x i8> %vec) {
; CHECK-LABEL: @tbl1_8x8_out_of_range(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[VTBL1:%.*]] = call <8 x i8> @llvm.arm.neon.vtbl1(<8 x i8> [[VEC:%.*]], <8 x i8> <i8 8, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0>)
; CHECK-NEXT:    ret <8 x i8> [[VTBL1]]
;
entry:
  %vtbl1 = call <8 x i8> @llvm.arm.neon.vtbl1(<8 x i8> %vec, <8 x i8> <i8 8, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0>)
  ret <8 x i8> %vtbl1
}

declare <8 x i8> @llvm.arm.neon.vtbl1(<8 x i8>, <8 x i8>)
