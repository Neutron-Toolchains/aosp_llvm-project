; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define <2 x double> @test_round_sd(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: @test_round_sd(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> [[A:%.*]], <2 x double> [[B:%.*]], i32 10)
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = insertelement <2 x double> %a, double 1.000000e+00, i32 0
  %2 = insertelement <2 x double> %b, double 2.000000e+00, i32 1
  %3 = tail call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %1, <2 x double> %2, i32 10)
  ret <2 x double> %3
}

define double @test_round_sd_0(double %a, double %b) {
; CHECK-LABEL: @test_round_sd_0(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x double> undef, double [[B:%.*]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> undef, <2 x double> [[TMP1]], i32 10)
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x double> [[TMP2]], i32 0
; CHECK-NEXT:    ret double [[TMP3]]
;
  %1 = insertelement <2 x double> undef, double %a, i32 0
  %2 = insertelement <2 x double> %1, double 1.000000e+00, i32 1
  %3 = insertelement <2 x double> undef, double %b, i32 0
  %4 = insertelement <2 x double> %3, double 2.000000e+00, i32 1
  %5 = tail call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %2, <2 x double> %4, i32 10)
  %6 = extractelement <2 x double> %5, i32 0
  ret double %6
}

define double @test_round_sd_1(double %a, double %b) {
; CHECK-LABEL: @test_round_sd_1(
; CHECK-NEXT:    ret double 1.000000e+00
;
  %1 = insertelement <2 x double> undef, double %a, i32 0
  %2 = insertelement <2 x double> %1, double 1.000000e+00, i32 1
  %3 = insertelement <2 x double> undef, double %b, i32 0
  %4 = insertelement <2 x double> %3, double 2.000000e+00, i32 1
  %5 = tail call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %2, <2 x double> %4, i32 10)
  %6 = extractelement <2 x double> %5, i32 1
  ret double %6
}

define double @test_round_sd_2(double %a) {
; CHECK-LABEL: @test_round_sd_2(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x double> undef, double [[A:%.*]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> undef, <2 x double> [[TMP1]], i32 10)
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x double> [[TMP2]], i32 0
; CHECK-NEXT:    ret double [[TMP3]]
;
  %1 = insertelement <2 x double> zeroinitializer, double %a, i32 0
  %2 = tail call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %1, <2 x double> %1, i32 10)
  %3 = extractelement <2 x double> %2, i32 0
  ret double %3
}

define <4 x float> @test_round_ss(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: @test_round_ss(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> <float undef, float 1.000000e+00, float 2.000000e+00, float 3.000000e+00>, <4 x float> [[B:%.*]], i32 10)
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = insertelement <4 x float> %a, float 1.000000e+00, i32 1
  %2 = insertelement <4 x float> %1, float 2.000000e+00, i32 2
  %3 = insertelement <4 x float> %2, float 3.000000e+00, i32 3
  %4 = insertelement <4 x float> %b, float 1.000000e+00, i32 1
  %5 = insertelement <4 x float> %4, float 2.000000e+00, i32 2
  %6 = insertelement <4 x float> %5, float 3.000000e+00, i32 3
  %7 = tail call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> %3, <4 x float> %6, i32 10)
  ret <4 x float> %7
}

define float @test_round_ss_0(float %a, float %b) {
; CHECK-LABEL: @test_round_ss_0(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x float> undef, float [[B:%.*]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> undef, <4 x float> [[TMP1]], i32 10)
; CHECK-NEXT:    [[R:%.*]] = extractelement <4 x float> [[TMP2]], i32 0
; CHECK-NEXT:    ret float [[R]]
;
  %1 = insertelement <4 x float> undef, float %a, i32 0
  %2 = insertelement <4 x float> %1, float 1.000000e+00, i32 1
  %3 = insertelement <4 x float> %2, float 2.000000e+00, i32 2
  %4 = insertelement <4 x float> %3, float 3.000000e+00, i32 3
  %5 = insertelement <4 x float> undef, float %b, i32 0
  %6 = insertelement <4 x float> %5, float 4.000000e+00, i32 1
  %7 = insertelement <4 x float> %6, float 5.000000e+00, i32 2
  %8 = insertelement <4 x float> %7, float 6.000000e+00, i32 3
  %9 = tail call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> %4, <4 x float> %8, i32 10)
  %r = extractelement <4 x float> %9, i32 0
  ret float %r
}

define float @test_round_ss_2(float %a, float %b) {
; CHECK-LABEL: @test_round_ss_2(
; CHECK-NEXT:    ret float 2.000000e+00
;
  %1 = insertelement <4 x float> undef, float %a, i32 0
  %2 = insertelement <4 x float> %1, float 1.000000e+00, i32 1
  %3 = insertelement <4 x float> %2, float 2.000000e+00, i32 2
  %4 = insertelement <4 x float> %3, float 3.000000e+00, i32 3
  %5 = insertelement <4 x float> undef, float %b, i32 0
  %6 = insertelement <4 x float> %5, float 4.000000e+00, i32 1
  %7 = insertelement <4 x float> %6, float 5.000000e+00, i32 2
  %8 = insertelement <4 x float> %7, float 6.000000e+00, i32 3
  %9 = tail call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> %4, <4 x float> %8, i32 10)
  %r = extractelement <4 x float> %9, i32 2
  ret float %r
}

define float @test_round_ss_3(float %a) {
; CHECK-LABEL: @test_round_ss_3(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x float> undef, float [[A:%.*]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> undef, <4 x float> [[TMP1]], i32 10)
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x float> [[TMP2]], i32 0
; CHECK-NEXT:    ret float [[TMP3]]
;
  %1 = insertelement <4 x float> zeroinitializer, float %a, i32 0
  %2 = tail call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> %1, <4 x float> %1, i32 10)
  %3 = extractelement <4 x float> %2, i32 0
  ret float %3
}

declare <2 x double> @llvm.x86.sse41.round.sd(<2 x double>, <2 x double>, i32) nounwind readnone
declare <4 x float> @llvm.x86.sse41.round.ss(<4 x float>, <4 x float>, i32) nounwind readnone
