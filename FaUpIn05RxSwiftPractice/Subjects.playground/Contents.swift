import RxSwift

let disposeBag = DisposeBag()

print("-----PublishSubject1-----")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. Hello. How are you?")

let subscriber1 = publishSubject
    .subscribe(onNext: {
        print("1st subscriber: \($0)")
    })

publishSubject.onNext("2. Can you hear me?")
publishSubject.on(.next("3. Can't you?"))

subscriber1.dispose()

let subscriber2 = publishSubject
    .subscribe(onNext: {
        print("2nd subscriber: \($0)")
    })

publishSubject.onNext("4. Hello?")
publishSubject.onCompleted()

publishSubject.onNext("5. Are you done?")

subscriber2.dispose()

publishSubject
    .subscribe {
        print("3rd subscriber:", $0.element ?? $0) // $0: event type
    }
    .disposed(by: disposeBag)

publishSubject.onNext("6. Will this be printed?") // Observable is already completed.

print("-----BehaviorSubject-----")
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject(value: "0. default value")

behaviorSubject.onNext("1. 1st value")

behaviorSubject.subscribe {
    print("1st subscription:", $0.element ?? $0) // $0: event type
}
.disposed(by: disposeBag)

//behaviorSubject.onError(SubjectError.error1)

behaviorSubject.subscribe {
    print("2nd subscription:", $0.element ?? $0)
}
.disposed(by: disposeBag)

let value = try? behaviorSubject.value()
print(value ?? "nil")

print("-----ReplaySubject-----")
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. Everyone!")
replaySubject.onNext("2. Cheer up")
replaySubject.onNext("3. though it's difficult..")

replaySubject.subscribe {
    print("1st subscription:", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("2nd subscription:", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. You can do it.")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("3rd subscription:", $0.element ?? $0)
}
.disposed(by: disposeBag)



