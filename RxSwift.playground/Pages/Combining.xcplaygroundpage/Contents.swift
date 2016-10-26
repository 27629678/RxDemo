//: [Filtering](@previous)

import RxSwift
import Foundation

//:>任何一个ObservableSequences抛出Error，捆绑后的ObservableSequence立即停止

let disposeBag = DisposeBag()

let error = NSError(domain: "playground",
                    code: 404,
                    userInfo: ["key" : "description"])

//:![CombineLatest](RxSwift_CombineLatest.png)

run("Combine") {
    let source1 = PublishSubject<Int>()
    let source2 = PublishSubject<String>()
    
    Observable
        .combineLatest(source2,
                       source1,
                       resultSelector: { "N:\($0), A:\($1)" })
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
    
    source1.onNext(18)
    source2.onNext("xiao ming")
//    source2(error)
    source2.onNext("xiao hong")
    source1.onNext(20)
}

//:![Merge](RxSwift_Merge.png)

run("Merge") {
    let source1 = PublishSubject<String>()
    let source2 = PublishSubject<String>()
    
    Observable
        .of(source1, source2)
        .merge()
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
    
    source1.onNext("18")
    source2.onNext("xiao ming")
    
//    source1.onError(error)
    source2.onNext("xiao hong")
    source1.onNext("20")
}

//:>要Merge的Observables要求为同一类型，即Observable<Element>中**Element**相同

//:![StartWith](RxSwift_StartWith.png)

run("StartWith") { 
    Observable<Int>
        .range(start: 1, count: 2)
        .startWith(0)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![Zip](RxSwift_Zip.png)

run("Zip") { 
    let source1 = PublishSubject<String>()
    let source2 = PublishSubject<String>()
    
    Observable
        .zip(source2,
             source1,
             resultSelector: { "N:\($0), A:\($1)" })
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
    
    source1.onNext("18")
    source2.onNext("xiao ming")
    source1.onNext("19")
    source1.onNext("20")
    source1.onNext("21")
    source2.onNext("xiao hong")
    source1.onNext("22")
}

//:![Switch](RxSwift_Switch.png)

run("Switch") {
    runInfinite()
    let source1 = PublishSubject<String>()
    let source2 = PublishSubject<String>()
    
    Observable
        .of(source1, source2)
        .switchLatest()
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
    
    //    delay(0.1, action: {
    //        source2.onNext("xiao zhang")
    //    })
    
    delay(0.2, action: {
        source1.onNext("18")
    })
    
    delay(0.3, action: {
        source1.onNext("19")
    })
    
    delay(0.6, action: {
        source1.onNext("20")
    })
    
    delay(0.4, action: {
        source2.onNext("xiao ming")
    })
    
    delay(0.9, action: {
        source2.onNext("xiao hong")
    })
    
    delay(1.2, action: {
        source1.onNext("21")
    })
}

//:>与图片描述不符，未验证其实现方法

//: [ErrorHandling](@next)
