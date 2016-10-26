//: [Combining](@previous)

import RxSwift
import Foundation

let disposeBag = DisposeBag()

let error = NSError(domain: "playground",
                    code: 404,
                    userInfo: ["key" : "description"])

//:![Catch](RxSwift_Catch.png)

run("Catch") {
    var count = 1
    
    let sequenceThatErrors =
        Observable<String>.create { observer in
            observer.onNext("🍎")
            observer.onNext("🍐")
            observer.onNext("🍊")
            
            if count == 1 {
                observer.onError(error)
                print("Error encountered")
                count += 1
            }
            
            observer.onNext("🐶")
            observer.onNext("🐱")
            observer.onNext("🐭")
            observer.onCompleted()
            
            return Disposables.create()
    }
    
    sequenceThatErrors
        .catchError({ (error) -> Observable<String> in
            return Observable.of("error")
        })
//        .catchErrorJustReturn("error")
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

//:![Retry](RxSwift_Retry.png)

run("Retry") {
    var count = 1
    
    let sequenceThatErrors =
        Observable<String>.create { observer in
            observer.onNext("🍎")
            observer.onNext("🍐")
            observer.onNext("🍊")
            
            if count == 1 {
                observer.onError(error)
                print("Error encountered")
                count += 1
            }
            
            observer.onNext("🐶")
            observer.onNext("🐱")
            observer.onNext("🐭")
            observer.onCompleted()
            
            return Disposables.create()
    }
    
    sequenceThatErrors
        .retry()
//        .retry(2)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

//:>注意Retry与Catch同时使用有副作用，比如，不可以多次Retry；同时要与Try、Catch的作用区分开
