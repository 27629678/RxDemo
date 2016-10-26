//: [Transforming](@previous)

import RxSwift
import Foundation

let disposeBag = DisposeBag()

//:![Filter](RxSwift_Filter.png)

run("Filter") { 
    Observable<Int>
        .range(start: 0, count: 10)
        .filter({$0 > 5 && $0 < 8})
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![IgnoreElements](RxSwift_Ignore.png)

run("IgnoreElements") { 
    Observable<Int>
        .range(start: 0, count: 10)
        .ignoreElements()
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![ElementAt](RxSwift_ElementAt.png)

run("ElementAt") {
    Observable<Int>
        .range(start: 0, count: 10)
        .elementAt(8)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![DistinctUntilChanged](RxSwift_Distinct.png)

run("DistinctUntilChanged") { 
    Observable<Int>
        .range(start: 0, count: 100)
        .map({String($0).characters.count})
        .distinctUntilChanged()
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![Skip](RxSwift_Skip.png)

run("Skip") { 
    Observable<Int>
        .range(start: 0, count: 5)
        .skip(3)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![SkipWhile](RxSwift_SkipWhile.png)

run("SkipWhile") { 
    Observable<Int>
        .range(start: 0, count: 5)
        .skipWhile({ (number) -> Bool in
            return number < 3
        })
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![SkipUntil](RxSwift_SkipUntil.png)

run("SkipUntil") {
    let source = PublishSubject<Int>()
    let skip = PublishSubject<Int>()
    
    source
        .skipUntil(skip)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
    
    source.onNext(0)
    source.onNext(1)
    source.onNext(2)
    
    skip.onNext(3)
    
    source.onNext(4)
    source.onNext(5)
}

run("SkipDuration") {
    Observable<Int>
        .range(start: 0, count: 5)
        .skip(1, scheduler: MainScheduler.instance)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

run("SkipWhileWithIndex") {
    Observable<Int>
        .range(start: 0, count: 5)
        .skipWhileWithIndex({ (number, index) -> Bool in
            return number < 2 && index < 3
        })
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:>Skip内的条件判断比较坑，只要不满足条件就开始抛事件

//:![Take](RxSwift_Take.png)

run("Take") { 
    Observable<Int>
        .range(start: 0, count: 5)
        .take(3)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![TakeLast](RxSwift_TakeLast.png)

run("TakeLast") {
    Observable<Int>
        .range(start: 0, count: 5)
        .takeLast(2)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:>TakeUntil()+TakeWhile()+TtakeWhileWithIndex()这几个方法的操作与**Skip**类似，不再重复举例

//:![Debounce](RxSwift_Debounce.png)

runInfinite()

//run("Debounce") {
//    let subject = PublishSubject<String>()
//    
//    Observable.of(subject)
//        .merge()
//        .debounce(1, scheduler: MainScheduler.instance)
//        .subscribe({print("Debounce:\($0)")})
//        .addDisposableTo(disposeBag)
//    
//    subject.onNext("0")
//    
//    delay(1, action: { 
//        subject.onNext("1")
//    })
//    
//    delay(1.8, action: {
//        subject.onNext("1.8")
//    })
//    
//    delay(2.3, action: {
//        subject.onNext("2.3")
//    })
//    
//    delay(3, action: { 
//        subject.onNext("3")
//    })
//}

//:![Throttle](RxSwift_Throttle.png)

run("Throttle") {
    let subject = PublishSubject<String>()
    
    Observable.of(subject)
        .merge()
//        .throttle(1, scheduler: MainScheduler.instance)
        .throttle(2, latest: true, scheduler: MainScheduler.instance)
        .subscribe({print("Throttle:\($0)")})
        .addDisposableTo(disposeBag)
    
    subject.onNext("0")
    
    delay(0.3, action: {
        subject.onNext("0.3")
    })
    
    delay(0.6, action: { 
        subject.onNext("0.6")
    })
    
    delay(1.3, action: { 
        subject.onNext("1.3")
    })
    
    delay(1.8, action: {
        subject.onNext("1.8")
    })
    
    delay(2.3, action: {
        subject.onNext("2.3")
    })
    
    delay(2.9, action: { 
        subject.onNext("2.9")
    })
    
    delay(3, action: {
        subject.onNext("3")
    })
    
    delay(4, action: { 
        subject.onNext("4")
    })
}

//:>与图片描述不符，取每个时间间隔内最早抛出的事件

delay(5) { 
    stopRun()
}

//: [ErrorHandling](@next)
