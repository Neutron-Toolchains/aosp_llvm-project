; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=m68k-linux -verify-machineinstrs | FileCheck %s

%struct.va_list = type { i8* }

define i32 @test(i32 %X, ...) {
  ; Initialize variable argument processing
; CHECK-LABEL: test:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    suba.l #8, %sp
; CHECK-NEXT:    .cfi_def_cfa_offset -12
; CHECK-NEXT:    lea (16,%sp), %a0
; CHECK-NEXT:    move.l %a0, %d0
; CHECK-NEXT:    add.l #4, %d0
; CHECK-NEXT:    move.l %d0, (4,%sp)
; CHECK-NEXT:    move.l %d0, (0,%sp)
; CHECK-NEXT:    move.l (16,%sp), %d0
; CHECK-NEXT:    adda.l #8, %sp
; CHECK-NEXT:    rts
  %ap = alloca %struct.va_list
  %ap2 = bitcast %struct.va_list* %ap to i8*
  call void @llvm.va_start(i8* %ap2)

  ; Read a single integer argument
  %tmp = va_arg i8* %ap2, i32

  ; Demonstrate usage of llvm.va_copy and llvm.va_end
  %aq = alloca i8*
  %aq2 = bitcast i8** %aq to i8*
  call void @llvm.va_copy(i8* %aq2, i8* %ap2)
  call void @llvm.va_end(i8* %aq2)

  ; Stop processing of arguments.
  call void @llvm.va_end(i8* %ap2)
  ret i32 %tmp
}

declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
