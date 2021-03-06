; RUN: opt -passes=newgvn -S < %s | FileCheck %s

define double @test1(double %x, double %y) {
; CHECK: @test1(double %x, double %y)
; CHECK: %add1 = fadd double %x, %y
; CHECK-NOT: fpmath
; CHECK: %foo = fadd double %add1, %add1
  %add1 = fadd double %x, %y, !fpmath !0
  %add2 = fadd double %x, %y
  %foo = fadd double %add1, %add2
  ret double %foo
}

define double @test2(double %x, double %y) {
; CHECK: @test2(double %x, double %y)
; CHECK: %add1 = fadd double %x, %y, !fpmath ![[MD0:[0-9]+]]
; CHECK: %foo = fadd double %add1, %add1
  %add1 = fadd double %x, %y, !fpmath !0
  %add2 = fadd double %x, %y, !fpmath !0
  %foo = fadd double %add1, %add2
  ret double %foo
}

define double @test3(double %x, double %y) {
; CHECK: @test3(double %x, double %y)
; CHECK: %add1 = fadd double %x, %y, !fpmath ![[MD1:[0-9]+]]
; CHECK: %foo = fadd double %add1, %add1
  %add1 = fadd double %x, %y, !fpmath !1
  %add2 = fadd double %x, %y, !fpmath !0
  %foo = fadd double %add1, %add2
  ret double %foo
}

define double @test4(double %x, double %y) {
; CHECK: @test4(double %x, double %y)
; CHECK: %add1 = fadd double %x, %y, !fpmath ![[MD1]]
; CHECK: %foo = fadd double %add1, %add1
  %add1 = fadd double %x, %y, !fpmath !0
  %add2 = fadd double %x, %y, !fpmath !1
  %foo = fadd double %add1, %add2
  ret double %foo
}

define double @test5(double %x) {
; CHECK: @test5(double %x)
; CHECK: %neg1 = fneg double %x, !fpmath ![[MD1]]
; CHECK: %foo = fadd double %neg1, %neg1
  %neg1 = fneg double %x, !fpmath !0
  %neg2 = fneg double %x, !fpmath !1
  %foo = fadd double %neg1, %neg2
  ret double %foo
}

; CHECK: ![[MD0]] = !{float 5.000000e+00}
; CHECK: ![[MD1]] = !{float 2.500000e+00}

!0 = !{ float 5.0 }
!1 = !{ float 2.5 }
