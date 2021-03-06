; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -passes=instsimplify -S | FileCheck %s

; Here we subtract two values, check that subtraction did not overflow AND
; that the result is non-zero. This can be simplified just to a comparison
; between the base and offset.

declare void @use8(i8)
declare void @use64(i64)
declare void @use1(i1)

declare void @llvm.assume(i1)

; If we are checking that we either did not get null or got no overflow,
; this is tautological and is always true.

define i1 @commutativity0(i8 %base, i8 %offset) {
; CHECK-LABEL: @commutativity0(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp uge i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    call void @use1(i1 [[NO_UNDERFLOW]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp ne i8 [[ADJUSTED]], 0
; CHECK-NEXT:    call void @use1(i1 [[NOT_NULL]])
; CHECK-NEXT:    ret i1 true
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %no_underflow = icmp uge i8 %base, %offset
  call void @use1(i1 %no_underflow)
  %not_null = icmp ne i8 %adjusted, 0
  call void @use1(i1 %not_null)
  %r = or i1 %not_null, %no_underflow
  ret i1 %r
}
define i1 @commutativity1(i8 %base, i8 %offset) {
; CHECK-LABEL: @commutativity1(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp ule i8 [[OFFSET]], [[BASE]]
; CHECK-NEXT:    call void @use1(i1 [[NO_UNDERFLOW]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp ne i8 [[ADJUSTED]], 0
; CHECK-NEXT:    call void @use1(i1 [[NOT_NULL]])
; CHECK-NEXT:    ret i1 true
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %no_underflow = icmp ule i8 %offset, %base ; swapped
  call void @use1(i1 %no_underflow)
  %not_null = icmp ne i8 %adjusted, 0
  call void @use1(i1 %not_null)
  %r = or i1 %not_null, %no_underflow
  ret i1 %r
}
define i1 @commutativity2(i8 %base, i8 %offset) {
; CHECK-LABEL: @commutativity2(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp uge i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    call void @use1(i1 [[NO_UNDERFLOW]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp ne i8 [[ADJUSTED]], 0
; CHECK-NEXT:    call void @use1(i1 [[NOT_NULL]])
; CHECK-NEXT:    ret i1 true
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %no_underflow = icmp uge i8 %base, %offset
  call void @use1(i1 %no_underflow)
  %not_null = icmp ne i8 %adjusted, 0
  call void @use1(i1 %not_null)
  %r = or i1 %no_underflow, %not_null ; swapped
  ret i1 %r
}

define i1 @commutativity3(i8 %base, i8 %offset) {
; CHECK-LABEL: @commutativity3(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp ule i8 [[OFFSET]], [[BASE]]
; CHECK-NEXT:    call void @use1(i1 [[NO_UNDERFLOW]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp ne i8 [[ADJUSTED]], 0
; CHECK-NEXT:    call void @use1(i1 [[NOT_NULL]])
; CHECK-NEXT:    ret i1 true
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %no_underflow = icmp ule i8 %offset, %base ; swapped
  call void @use1(i1 %no_underflow)
  %not_null = icmp ne i8 %adjusted, 0
  call void @use1(i1 %not_null)
  %r = or i1 %no_underflow, %not_null ; swapped
  ret i1 %r
}

;-------------------------------------------------------------------------------

define i1 @exaustive_t0_no_underflow(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t0_no_underflow(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp ult i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    ret i1 [[NO_UNDERFLOW]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp ne i8 %adjusted, 0
  %no_underflow = icmp ult i8 %base, %offset
  %r = and i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t1_not_null(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t1_not_null(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp ne i8 [[ADJUSTED]], 0
; CHECK-NEXT:    ret i1 [[NOT_NULL]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp ne i8 %adjusted, 0
  %no_underflow = icmp ult i8 %base, %offset
  %r = or i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t2_false(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t2_false(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    ret i1 false
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp eq i8 %adjusted, 0
  %no_underflow = icmp ult i8 %base, %offset
  %r = and i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t3_bad(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t3_bad(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp eq i8 [[ADJUSTED]], 0
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp ult i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    [[R:%.*]] = or i1 [[NO_UNDERFLOW]], [[NOT_NULL]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp eq i8 %adjusted, 0
  %no_underflow = icmp ult i8 %base, %offset
  %r = or i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t4_no_underflow(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t4_no_underflow(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp ugt i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    ret i1 [[NO_UNDERFLOW]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp ne i8 %adjusted, 0
  %no_underflow = icmp ugt i8 %base, %offset
  %r = and i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t5_not_null(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t5_not_null(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp ne i8 [[ADJUSTED]], 0
; CHECK-NEXT:    ret i1 [[NOT_NULL]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp ne i8 %adjusted, 0
  %no_underflow = icmp ugt i8 %base, %offset
  %r = or i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t6_false(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t6_false(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    ret i1 false
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp eq i8 %adjusted, 0
  %no_underflow = icmp ugt i8 %base, %offset
  %r = and i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t7_bad(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t7_bad(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp eq i8 [[ADJUSTED]], 0
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp ugt i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    [[R:%.*]] = or i1 [[NO_UNDERFLOW]], [[NOT_NULL]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp eq i8 %adjusted, 0
  %no_underflow = icmp ugt i8 %base, %offset
  %r = or i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t8_bad(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t8_bad(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp ne i8 [[ADJUSTED]], 0
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp ule i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    [[R:%.*]] = and i1 [[NO_UNDERFLOW]], [[NOT_NULL]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp ne i8 %adjusted, 0
  %no_underflow = icmp ule i8 %base, %offset
  %r = and i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t9_true(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t9_true(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    ret i1 true
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp ne i8 %adjusted, 0
  %no_underflow = icmp ule i8 %base, %offset
  %r = or i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t10_not_null(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t10_not_null(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp eq i8 [[ADJUSTED]], 0
; CHECK-NEXT:    ret i1 [[NOT_NULL]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp eq i8 %adjusted, 0
  %no_underflow = icmp ule i8 %base, %offset
  %r = and i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t11_no_underflow(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t11_no_underflow(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp ule i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    ret i1 [[NO_UNDERFLOW]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp eq i8 %adjusted, 0
  %no_underflow = icmp ule i8 %base, %offset
  %r = or i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t12_bad(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t12_bad(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp ne i8 [[ADJUSTED]], 0
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp uge i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    [[R:%.*]] = and i1 [[NO_UNDERFLOW]], [[NOT_NULL]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp ne i8 %adjusted, 0
  %no_underflow = icmp uge i8 %base, %offset
  %r = and i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t13_true(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t13_true(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    ret i1 true
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp ne i8 %adjusted, 0
  %no_underflow = icmp uge i8 %base, %offset
  %r = or i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t14_not_null(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t14_not_null(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NOT_NULL:%.*]] = icmp eq i8 [[ADJUSTED]], 0
; CHECK-NEXT:    ret i1 [[NOT_NULL]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp eq i8 %adjusted, 0
  %no_underflow = icmp uge i8 %base, %offset
  %r = and i1 %no_underflow, %not_null
  ret i1 %r
}

define i1 @exaustive_t15_no_underflow(i8 %base, i8 %offset) {
; CHECK-LABEL: @exaustive_t15_no_underflow(
; CHECK-NEXT:    [[ADJUSTED:%.*]] = sub i8 [[BASE:%.*]], [[OFFSET:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[ADJUSTED]])
; CHECK-NEXT:    [[NO_UNDERFLOW:%.*]] = icmp uge i8 [[BASE]], [[OFFSET]]
; CHECK-NEXT:    ret i1 [[NO_UNDERFLOW]]
;
  %adjusted = sub i8 %base, %offset
  call void @use8(i8 %adjusted)
  %not_null = icmp eq i8 %adjusted, 0
  %no_underflow = icmp uge i8 %base, %offset
  %r = or i1 %no_underflow, %not_null
  ret i1 %r
}
