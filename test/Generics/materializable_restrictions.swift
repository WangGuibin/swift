// RUN: %target-parse-verify-swift

func test15921520() {
    var x: Int = 0
    func f<T>(x: T) {}
    f(&x) // expected-error{{cannot invoke 'f' with an argument list of type '(inout Int)'}} expected-note{{expected an argument list of type '(T)'}}
}

func test20807269() {
    var x: Int = 0
    func f<T>(x: T) {}
    // expected-note @+1 {{expected an argument list of type '(T)'}}
    f(1, &x) // expected-error{{cannot invoke 'f' with an argument list of type '(Int, inout Int)'}}
}

func test15921530() {
    struct X {}

    func makef<T>() -> (T)->() {
      return {
        x in ()
      }
    }
    // FIXME: poor error message.
    var _: (inout X)->() = makef() // expected-error{{'() -> (_) -> ()' is not a subtype of '()'}}
}
