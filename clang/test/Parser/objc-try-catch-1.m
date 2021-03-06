// RUN: %clang_cc1 -triple x86_64-apple-macosx10.10 -fsyntax-only -verify -fobjc-exceptions %s
// RUN: %clang_cc1 -triple x86_64-apple-macosx10.10 -fsyntax-only -verify -fobjc-exceptions -x objective-c++ %s
void * proc(void);

@interface NSConstantString
@end

@interface Frob
@end

@interface Frob1
@end

void * foo(void)
{
  @try {
    return proc();
  }
  @catch (Frob* ex) {
    @throw;
  }
  @catch (Frob1* ex) {
    @throw proc();
  }
  @finally {
    @try {
      return proc();
    }
    @catch (Frob* ex) {
      @throw 1,2; // expected-error {{@throw requires an Objective-C object type ('int' invalid)}} \
				  // expected-warning {{left operand of comma operator has no effect}}
    }
    @catch (float x) {  // expected-error {{@catch parameter is not a pointer to an interface type}}
      
    }
    @catch(...) {
      @throw (4,3,proc()); // expected-warning 2{{left operand of comma operator has no effect}}
    }
  }

  @try {  // expected-error {{@try statement without a @catch and @finally clause}}
    return proc();
  }
}


void bar(void)
{
  @try {}// expected-error {{@try statement without a @catch and @finally clause}}
  @"s"; //  expected-warning {{result unused}}
}

void baz(void)
{
  @try {}// expected-error {{@try statement without a @catch and @finally clause}}
  @try {}
  @finally {}
}

void noTwoTokenLookAheadRequiresABitOfFancyFootworkInTheParser(void) {
    @try {
        // Do something
    } @catch (...) {}
    @try {
        // Do something
    } @catch (...) {}
    return;
}

