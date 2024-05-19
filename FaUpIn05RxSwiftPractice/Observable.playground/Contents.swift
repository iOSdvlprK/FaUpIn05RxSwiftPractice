import Foundation
import RxSwift

print("-----Just-----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("-----Of1-----")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("-----Of2-----")
Observable.of([1, 2, 3, 4, 5])  // = Observable.just([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("-----From-----")
Observable.from([1, 2, 3, 4, 5])  // only receives array form
    .subscribe(onNext: {
        print($0)
    })

print("-----subscribe1-----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("-----subscribe2-----")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("-----subscribe3-----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

print("-----empty-----")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("-----never-----")
Observable<Void>.never()
    .debug("never")
    .subscribe(
        onNext: {
            print($0)
        },
        onCompleted: {
            print("Completed")
        }
    )

print("-----range-----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2 * \($0) = \(2 * $0)")
    })

print("-----dispose-----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .dispose()

print("-----disposeBag-----")
let disposeBag = DisposeBag()
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

print("-----create1-----")
Observable.create({ observer -> Disposable in
    observer.onNext(1)
//    observer.on(.next(1))
    observer.onCompleted()
//    observer.on(.completed)
    observer.onNext(2)
    return Disposables.create()
})
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-----create2-----")
enum MyError: Error {
    case anError
}
Observable<Int>.create({ observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
})
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)

print("-----deferred1-----")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-----deferred2-----")
var flip: Bool = false
let factory: Observable<String> = Observable.deferred {
    flip = !flip
    if flip {
        return Observable.of("☝️")
    } else {
        return Observable.of("👎")
    }
}
for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}

