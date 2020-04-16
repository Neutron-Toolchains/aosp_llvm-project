; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s  -cost-model -analyze -mtriple=x86_64-apple-macosx10.8.0 -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: opt < %s  -cost-model -analyze -mtriple=x86_64-apple-macosx10.8.0 -mattr=+avx  | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: opt < %s  -cost-model -analyze -mtriple=x86_64-apple-macosx10.8.0 -mattr=+avx512bw | FileCheck %s --check-prefixes=CHECK,AVX512

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.8.0"

define i32 @stores(i32 %arg) {
; SSE-LABEL: 'stores'
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i8 undef, i8* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 undef, i16* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i32 undef, i32* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i64 undef, i64* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i128 undef, i128* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i16> undef, <4 x i16>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i32> undef, <4 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <4 x i64> undef, <4 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x i16> undef, <8 x i16>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <8 x i32> undef, <8 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: store <8 x i64> undef, <8 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x float> undef, <3 x float>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x double> undef, <3 x double>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x i32> undef, <3 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x i64> undef, <3 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: store <5 x i32> undef, <5 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <5 x i64> undef, <5 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX-LABEL: 'stores'
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i8 undef, i8* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 undef, i16* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i32 undef, i32* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i64 undef, i64* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i128 undef, i128* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i16> undef, <4 x i16>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i32> undef, <4 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i64> undef, <4 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x i16> undef, <8 x i16>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x i32> undef, <8 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <8 x i64> undef, <8 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x float> undef, <3 x float>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x double> undef, <3 x double>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x i32> undef, <3 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x i64> undef, <3 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: store <5 x i32> undef, <5 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <5 x i64> undef, <5 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX512-LABEL: 'stores'
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i8 undef, i8* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 undef, i16* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i32 undef, i32* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i64 undef, i64* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i128 undef, i128* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i16> undef, <4 x i16>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i32> undef, <4 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i64> undef, <4 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x i16> undef, <8 x i16>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x i32> undef, <8 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x i64> undef, <8 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x float> undef, <3 x float>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x double> undef, <3 x double>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x i32> undef, <3 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: store <3 x i64> undef, <3 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: store <5 x i32> undef, <5 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: store <5 x i64> undef, <5 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  store i8 undef, i8* undef, align 4
  store i16 undef, i16* undef, align 4
  store i32 undef, i32* undef, align 4
  store i64 undef, i64* undef, align 4
  store i128 undef, i128* undef, align 4

  store <4 x i16> undef, <4 x i16>* undef, align 4
  store <4 x i32> undef, <4 x i32>* undef, align 4
  store <4 x i64> undef, <4 x i64>* undef, align 4

  store <8 x i16> undef, <8 x i16>* undef, align 4
  store <8 x i32> undef, <8 x i32>* undef, align 4
  store <8 x i64> undef, <8 x i64>* undef, align 4

  store <3 x float> undef, <3 x float>* undef, align 4
  store <3 x double> undef, <3 x double>* undef, align 4

  store <3 x i32> undef, <3 x i32>* undef, align 4
  store <3 x i64> undef, <3 x i64>* undef, align 4
  store <5 x i32> undef, <5 x i32>* undef, align 4
  store <5 x i64> undef, <5 x i64>* undef, align 4

  ret i32 undef
}

define i32 @loads(i32 %arg) {
; SSE-LABEL: 'loads'
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %1 = load i8, i8* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %2 = load i16, i16* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %3 = load i32, i32* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %4 = load i64, i64* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %5 = load i128, i128* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %6 = load <2 x i32>, <2 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %7 = load <4 x i32>, <4 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %8 = load <8 x i32>, <8 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %9 = load <2 x i64>, <2 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %10 = load <4 x i64>, <4 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %11 = load <8 x i64>, <8 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %12 = load <3 x float>, <3 x float>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %13 = load <3 x double>, <3 x double>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %14 = load <3 x i32>, <3 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %15 = load <3 x i64>, <3 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %16 = load <5 x i32>, <5 x i32>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %17 = load <5 x i64>, <5 x i64>* undef, align 4
; SSE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX-LABEL: 'loads'
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %1 = load i8, i8* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %2 = load i16, i16* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %3 = load i32, i32* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %4 = load i64, i64* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %5 = load i128, i128* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %6 = load <2 x i32>, <2 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %7 = load <4 x i32>, <4 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %8 = load <8 x i32>, <8 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %9 = load <2 x i64>, <2 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %10 = load <4 x i64>, <4 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %11 = load <8 x i64>, <8 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %12 = load <3 x float>, <3 x float>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %13 = load <3 x double>, <3 x double>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %14 = load <3 x i32>, <3 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %15 = load <3 x i64>, <3 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %16 = load <5 x i32>, <5 x i32>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %17 = load <5 x i64>, <5 x i64>* undef, align 4
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX512-LABEL: 'loads'
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %1 = load i8, i8* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %2 = load i16, i16* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %3 = load i32, i32* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %4 = load i64, i64* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %5 = load i128, i128* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %6 = load <2 x i32>, <2 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %7 = load <4 x i32>, <4 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %8 = load <8 x i32>, <8 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %9 = load <2 x i64>, <2 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %10 = load <4 x i64>, <4 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %11 = load <8 x i64>, <8 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %12 = load <3 x float>, <3 x float>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %13 = load <3 x double>, <3 x double>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %14 = load <3 x i32>, <3 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %15 = load <3 x i64>, <3 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %16 = load <5 x i32>, <5 x i32>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %17 = load <5 x i64>, <5 x i64>* undef, align 4
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  load i8, i8* undef, align 4
  load i16, i16* undef, align 4
  load i32, i32* undef, align 4
  load i64, i64* undef, align 4
  load i128, i128* undef, align 4

  load <2 x i32>, <2 x i32>* undef, align 4
  load <4 x i32>, <4 x i32>* undef, align 4
  load <8 x i32>, <8 x i32>* undef, align 4

  load <2 x i64>, <2 x i64>* undef, align 4
  load <4 x i64>, <4 x i64>* undef, align 4
  load <8 x i64>, <8 x i64>* undef, align 4

  load <3 x float>, <3 x float>* undef, align 4
  load <3 x double>, <3 x double>* undef, align 4

  load <3 x i32>, <3 x i32>* undef, align 4
  load <3 x i64>, <3 x i64>* undef, align 4
  load <5 x i32>, <5 x i32>* undef, align 4
  load <5 x i64>, <5 x i64>* undef, align 4

  ret i32 undef
}
