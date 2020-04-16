// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple thumbv8.1m.main-arm-none-eabi \
// RUN:   -target-feature +cdecp0 -target-feature +cdecp1 \
// RUN:   -mfloat-abi hard -O0 -disable-O0-optnone \
// RUN:   -S -emit-llvm -o - %s | opt -S -mem2reg | FileCheck %s

#include <arm_cde.h>

// CHECK-LABEL: @test_cx1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.arm.cde.cx1(i32 0, i32 123)
// CHECK-NEXT:    ret i32 [[TMP0]]
//
uint32_t test_cx1(void) {
  return __arm_cx1(0, 123);
}

// CHECK-LABEL: @test_cx1a(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.arm.cde.cx1a(i32 0, i32 [[ACC:%.*]], i32 345)
// CHECK-NEXT:    ret i32 [[TMP0]]
//
uint32_t test_cx1a(uint32_t acc) {
  return __arm_cx1a(0, acc, 345);
}

// CHECK-LABEL: @test_cx1d(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call { i32, i32 } @llvm.arm.cde.cx1d(i32 1, i32 567)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { i32, i32 } [[TMP0]], 1
// CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
// CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[TMP2]], 32
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i32 } [[TMP0]], 0
// CHECK-NEXT:    [[TMP5:%.*]] = zext i32 [[TMP4]] to i64
// CHECK-NEXT:    [[TMP6:%.*]] = or i64 [[TMP3]], [[TMP5]]
// CHECK-NEXT:    ret i64 [[TMP6]]
//
uint64_t test_cx1d(void) {
  return __arm_cx1d(1, 567);
}

// CHECK-LABEL: @test_cx1da(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = lshr i64 [[ACC:%.*]], 32
// CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[ACC]] to i32
// CHECK-NEXT:    [[TMP3:%.*]] = call { i32, i32 } @llvm.arm.cde.cx1da(i32 0, i32 [[TMP2]], i32 [[TMP1]], i32 789)
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i32 } [[TMP3]], 1
// CHECK-NEXT:    [[TMP5:%.*]] = zext i32 [[TMP4]] to i64
// CHECK-NEXT:    [[TMP6:%.*]] = shl i64 [[TMP5]], 32
// CHECK-NEXT:    [[TMP7:%.*]] = extractvalue { i32, i32 } [[TMP3]], 0
// CHECK-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
// CHECK-NEXT:    [[TMP9:%.*]] = or i64 [[TMP6]], [[TMP8]]
// CHECK-NEXT:    ret i64 [[TMP9]]
//
uint64_t test_cx1da(uint64_t acc) {
  return __arm_cx1da(0, acc, 789);
}

// CHECK-LABEL: @test_cx2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.arm.cde.cx2(i32 0, i32 [[N:%.*]], i32 11)
// CHECK-NEXT:    ret i32 [[TMP0]]
//
uint32_t test_cx2(uint32_t n) {
  return __arm_cx2(0, n, 11);
}

// CHECK-LABEL: @test_cx2a(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.arm.cde.cx2a(i32 1, i32 [[ACC:%.*]], i32 [[N:%.*]], i32 22)
// CHECK-NEXT:    ret i32 [[TMP0]]
//
uint32_t test_cx2a(uint32_t acc, uint32_t n) {
  return __arm_cx2a(1, acc, n, 22);
}

// CHECK-LABEL: @test_cx2d(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call { i32, i32 } @llvm.arm.cde.cx2d(i32 1, i32 [[N:%.*]], i32 33)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { i32, i32 } [[TMP0]], 1
// CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
// CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[TMP2]], 32
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i32 } [[TMP0]], 0
// CHECK-NEXT:    [[TMP5:%.*]] = zext i32 [[TMP4]] to i64
// CHECK-NEXT:    [[TMP6:%.*]] = or i64 [[TMP3]], [[TMP5]]
// CHECK-NEXT:    ret i64 [[TMP6]]
//
uint64_t test_cx2d(uint32_t n) {
  return __arm_cx2d(1, n, 33);
}

// CHECK-LABEL: @test_cx2da(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = lshr i64 [[ACC:%.*]], 32
// CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[ACC]] to i32
// CHECK-NEXT:    [[TMP3:%.*]] = call { i32, i32 } @llvm.arm.cde.cx2da(i32 0, i32 [[TMP2]], i32 [[TMP1]], i32 [[N:%.*]], i32 44)
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i32 } [[TMP3]], 1
// CHECK-NEXT:    [[TMP5:%.*]] = zext i32 [[TMP4]] to i64
// CHECK-NEXT:    [[TMP6:%.*]] = shl i64 [[TMP5]], 32
// CHECK-NEXT:    [[TMP7:%.*]] = extractvalue { i32, i32 } [[TMP3]], 0
// CHECK-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
// CHECK-NEXT:    [[TMP9:%.*]] = or i64 [[TMP6]], [[TMP8]]
// CHECK-NEXT:    ret i64 [[TMP9]]
//
uint64_t test_cx2da(uint64_t acc, uint32_t n) {
  return __arm_cx2da(0, acc, n, 44);
}

// CHECK-LABEL: @test_cx3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.arm.cde.cx3(i32 0, i32 [[N:%.*]], i32 [[M:%.*]], i32 1)
// CHECK-NEXT:    ret i32 [[TMP0]]
//
uint32_t test_cx3(uint32_t n, uint32_t m) {
  return __arm_cx3(0, n, m, 1);
}

// CHECK-LABEL: @test_cx3a(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.arm.cde.cx3a(i32 1, i32 [[ACC:%.*]], i32 [[N:%.*]], i32 [[M:%.*]], i32 2)
// CHECK-NEXT:    ret i32 [[TMP0]]
//
uint32_t test_cx3a(uint32_t acc, uint32_t n, uint32_t m) {
  return __arm_cx3a(1, acc, n, m, 2);
}

// CHECK-LABEL: @test_cx3d(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call { i32, i32 } @llvm.arm.cde.cx3d(i32 1, i32 [[N:%.*]], i32 [[M:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { i32, i32 } [[TMP0]], 1
// CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
// CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[TMP2]], 32
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i32 } [[TMP0]], 0
// CHECK-NEXT:    [[TMP5:%.*]] = zext i32 [[TMP4]] to i64
// CHECK-NEXT:    [[TMP6:%.*]] = or i64 [[TMP3]], [[TMP5]]
// CHECK-NEXT:    ret i64 [[TMP6]]
//
uint64_t test_cx3d(uint32_t n, uint32_t m) {
  return __arm_cx3d(1, n, m, 3);
}

// CHECK-LABEL: @test_cx3da(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = lshr i64 [[ACC:%.*]], 32
// CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[ACC]] to i32
// CHECK-NEXT:    [[TMP3:%.*]] = call { i32, i32 } @llvm.arm.cde.cx3da(i32 0, i32 [[TMP2]], i32 [[TMP1]], i32 [[N:%.*]], i32 [[M:%.*]], i32 4)
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i32 } [[TMP3]], 1
// CHECK-NEXT:    [[TMP5:%.*]] = zext i32 [[TMP4]] to i64
// CHECK-NEXT:    [[TMP6:%.*]] = shl i64 [[TMP5]], 32
// CHECK-NEXT:    [[TMP7:%.*]] = extractvalue { i32, i32 } [[TMP3]], 0
// CHECK-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
// CHECK-NEXT:    [[TMP9:%.*]] = or i64 [[TMP6]], [[TMP8]]
// CHECK-NEXT:    ret i64 [[TMP9]]
//
uint64_t test_cx3da(uint64_t acc, uint32_t n, uint32_t m) {
  return __arm_cx3da(0, acc, n, m, 4);
}
