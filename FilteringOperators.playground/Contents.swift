import RxSwift

let disposeBag = DisposeBag()

print("-----ignoreElements-----")
let sleepingMode😴 = PublishSubject<String>()

sleepingMode😴
    .ignoreElements()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

sleepingMode😴.onNext("speaker🔈")
sleepingMode😴.onNext("speaker🔈")
sleepingMode😴.onNext("speaker🔈")

sleepingMode😴.onCompleted()

print("-----elementAt-----")
let wakerAtSecondTime = PublishSubject<String>()

wakerAtSecondTime
//    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

wakerAtSecondTime.onNext("speaker🔈")   // index 0
wakerAtSecondTime.onNext("speaker🔈")   // index 1
wakerAtSecondTime.onNext("rolling eyes🙄")   // index 2
wakerAtSecondTime.onNext("speaker🔈")   // index 3

print("-----filter-----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .filter { $0 < 6 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----skip-----")
Observable.of("😀", "😃", "😄", "🤓", "😎", "🐶")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----skipWhile-----")
Observable.of("😀", "😃", "😄", "🤓", "😎", "🐶", "😀", "😃")
    .skip(while: {
        $0 != "🐶"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----skipUntil-----")
let customer = PublishSubject<String>()
let openingHours = PublishSubject<String>()

customer
    .skip(until: openingHours)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

customer.onNext("😀")
customer.onNext("😃")

openingHours.onNext("chime!")
customer.onNext("😎")

print("-----take-----")
Observable.of("🥇", "🥈", "🥉", "🤓", "😎")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----takeWhile-----")
Observable.of("🥇", "🥈", "🥉", "🤓", "😎")
    .take(while: {
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----enumerated-----")
Observable.of("🥇", "🥈", "🥉", "🤓", "😎")
    .enumerated()
    .take(while: {
        $0.index < 3
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----takeUntil-----")
let enrollment = PublishSubject<String>()
let deadline = PublishSubject<String>()

enrollment
    .take(until: deadline)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

enrollment.onNext("🙋‍♀️")
enrollment.onNext("🙋🏻‍♂️")

deadline.onNext("Finished!")
enrollment.onNext("🙋🏻")

print("-----distinctUntilChanged-----")
Observable.of("I", "I", "a parrot", "a parrot", "a parrot", "am", "am", "am", "am", "I", "a parrot", "aren't I?", "aren't I?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)





