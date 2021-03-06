; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=dce -S | FileCheck %s

declare double @acos(double) nounwind willreturn
declare double @asin(double) nounwind willreturn
declare double @atan(double) nounwind willreturn
declare double @atan2(double, double) nounwind willreturn
declare double @ceil(double) nounwind willreturn
declare double @cos(double) nounwind willreturn
declare double @cosh(double) nounwind willreturn
declare double @exp(double) nounwind willreturn
declare double @exp2(double) nounwind willreturn
declare double @fabs(double) nounwind willreturn
declare double @floor(double) nounwind willreturn
declare double @fmod(double, double) nounwind willreturn
declare double @log(double) nounwind willreturn
declare double @log10(double) nounwind willreturn
declare double @pow(double, double) nounwind willreturn
declare double @sin(double) nounwind willreturn
declare double @sinh(double) nounwind willreturn
declare double @sqrt(double) nounwind willreturn
declare double @tan(double) nounwind willreturn
declare double @tanh(double) nounwind willreturn

declare float @acosf(float) nounwind willreturn
declare float @asinf(float) nounwind willreturn
declare float @atanf(float) nounwind willreturn
declare float @atan2f(float, float) nounwind willreturn
declare float @ceilf(float) nounwind willreturn
declare float @cosf(float) nounwind willreturn
declare float @coshf(float) nounwind willreturn
declare float @expf(float) nounwind willreturn
declare float @exp2f(float) nounwind willreturn
declare float @fabsf(float) nounwind willreturn
declare float @floorf(float) nounwind willreturn
declare float @fmodf(float, float) nounwind willreturn
declare float @logf(float) nounwind willreturn
declare float @log10f(float) nounwind willreturn willreturn
declare float @powf(float, float) nounwind willreturn
declare float @sinf(float) nounwind willreturn
declare float @sinhf(float) nounwind willreturn
declare float @sqrtf(float) nounwind willreturn
declare float @tanf(float) nounwind willreturn
declare float @tanhf(float) nounwind willreturn

define void @T() {
; CHECK-LABEL: @T(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOG1:%.*]] = call double @log(double 0.000000e+00)
; CHECK-NEXT:    [[LOG2:%.*]] = call double @log(double -1.000000e+00)
; CHECK-NEXT:    [[EXP2:%.*]] = call double @exp(double 1.000000e+03)
; CHECK-NEXT:    [[COS2:%.*]] = call double @cos(double 0x7FF0000000000000)
; CHECK-NEXT:    [[COS3:%.*]] = call double @cos(double 0.000000e+00) [[ATTR2:#.*]]
; CHECK-NEXT:    [[FMOD2:%.*]] = call double @fmod(double 0x7FF0000000000000, double 1.000000e+00)
; CHECK-NEXT:    ret void
;
entry:

; log(0) produces a pole error
  %log1 = call double @log(double 0.000000e+00)

; log(-1) produces a domain error
  %log2 = call double @log(double -1.000000e+00)

; log(1) is 0
  %log3 = call double @log(double 1.000000e+00)

; exp(100) is roughly 2.6e+43
  %exp1 = call double @exp(double 1.000000e+02)

; exp(1000) is a range error
  %exp2 = call double @exp(double 1.000000e+03)

; cos(0) is 1
  %cos1 = call double @cos(double 0.000000e+00)

; cos(inf) is a domain error
  %cos2 = call double @cos(double 0x7FF0000000000000)

; cos(0) nobuiltin may have side effects
  %cos3 = call double @cos(double 0.000000e+00) nobuiltin

; pow(0, 1) is 0
  %pow1 = call double @pow(double 0x7FF0000000000000, double 1.000000e+00)

; pow(0, -1) is a pole error
; FIXME: It fails on mingw host. Suppress checking.
; %pow2 = call double @pow(double 0.000000e+00, double -1.000000e+00)

; fmod(inf, nan) is nan
  %fmod1 = call double @fmod(double 0x7FF0000000000000, double 0x7FF0000000000001)

; fmod(inf, 1) is a domain error
  %fmod2 = call double @fmod(double 0x7FF0000000000000, double 1.000000e+00)

  ret void
}

define void @Tstrict() strictfp {
; CHECK-LABEL: @Tstrict(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COS4:%.*]] = call double @cos(double 1.000000e+00) [[ATTR1:#.*]]
; CHECK-NEXT:    ret void
;
entry:

; cos(1) strictfp sets FP status flags
  %cos4 = call double @cos(double 1.000000e+00) strictfp

  ret void
}
