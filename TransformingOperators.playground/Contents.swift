import RxSwift

let disposeBag = DisposeBag()

print("-----toArray-----")
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----map-----")
Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----flatMap-----")
protocol Player {
    var points: BehaviorSubject<Int> { get }
}

struct Archer: Player {
    var points: BehaviorSubject<Int>
}

let 🇰🇷teamKorea = Archer(points: BehaviorSubject<Int>(value: 10))
let 🇺🇸teamUSA = Archer(points: BehaviorSubject<Int>(value: 8))

let olympics = PublishSubject<Player>()

olympics
    .flatMap { player in
        player.points
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

olympics.onNext(🇰🇷teamKorea)
🇰🇷teamKorea.points.onNext(10)

olympics.onNext(🇺🇸teamUSA)
🇰🇷teamKorea.points.onNext(10)
🇺🇸teamUSA.points.onNext(9)

print("-----flatMapLatest-----")
struct PoleVaulter: Player {
    var points: BehaviorSubject<Int>
}

let seoul = PoleVaulter(points: BehaviorSubject<Int>(value: 7))
let jeju = PoleVaulter(points: BehaviorSubject<Int>(value: 6))

let nationalSportsFestival = PublishSubject<Player>()

nationalSportsFestival
    .flatMapLatest { player in
        player.points
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

nationalSportsFestival.onNext(seoul)
seoul.points.onNext(9)

nationalSportsFestival.onNext(jeju)
seoul.points.onNext(10)
jeju.points.onNext(8)

print("-----materialize and dematerialize-----")
enum Foul: Error {
    case falseStart
}

struct Runner: Player {
    var points: BehaviorSubject<Int>
}

let hareKim = Runner(points: BehaviorSubject<Int>(value: 0))
let cheetahPark = Runner(points: BehaviorSubject<Int>(value: 1))

let dash100M = BehaviorSubject<Player>(value: hareKim)

dash100M
    .flatMapLatest { player in
        player.points
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

hareKim.points.onNext(1)
hareKim.points.onError(Foul.falseStart)
hareKim.points.onNext(2)

dash100M.onNext(cheetahPark)

print("-----11 digit phone number-----")
let input = PublishSubject<Int?>()

let list: [Int] = [1]

input
    .flatMap {
        $0 == nil ? Observable.empty() : Observable.just($0)
    }
    .map { $0! }
    .skip(while: { $0 != 0 }) // skipping until 0 appears for '0'10-xxx-xxxx
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)" } // convert to string type
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3) // 010-
        numberList.insert("-", at: 8) // 010-1234-
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(4)
input.onNext(3)
input.onNext(nil)
input.onNext(1)
input.onNext(8)
input.onNext(9)
input.onNext(4)
input.onNext(9)
input.onNext(1)

