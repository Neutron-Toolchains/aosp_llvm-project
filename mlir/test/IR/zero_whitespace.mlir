// RUN: mlir-opt %s | FileCheck %s

// This test is in a different file because it contains a literal NUL
// character, which causes various tools to treat it as a binary file.
// Hence it is useful to have this test kept in a separate, rarely-changing
// file.

// CHECK-LABEL: func @zero_whitespace() {
// CHECK-NEXT: return
func.func @zero_whitespace() {
     // This is a \0 byte.
  return
}
