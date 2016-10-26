//: [About](@previous)

import RxSwift
import Foundation

let disposeBag = DisposeBag()

//:![Create](RxSwift_Create.png)

run("Create") { 
    let source = Observable<Int>.create { observer in
        for i in 1...5 {
            observer.onNext(i)
        }
        
        observer.onCompleted()
        
        return AnonymousDisposable {
            print("AnonymousDisposable")
        }
    }
    
    source
        .subscribe(
            onNext: { (number) in
                print(number)
            },
            onError: { (error) in
                print(error)
            },
            onCompleted: {
                print("completed")
            },
            onDisposed: {
                print("disposed")
        })
    
    source
        .subscribe({ (event) in
            guard let element = event.element else {
                return
            }
            
            print(event)
        })
}

//:> AnonymousDisposable{} 与 onDisposed:{}不同

//:![Create](RxSwift_Defered.png)

var count = 1

run("Defered") { 
    let source = Observable<String>.deferred({
        print("Creating \(count)")
        count += 1
        
        return Observable.create { observer in
            print("Emitting...")
            observer.onNext("🐶")
            observer.onNext("🐱")
            observer.onNext("🐵")
            
            return Disposables.create()
        }
    })
    
    source
        .subscribe(onNext: { print($0) })
    
    source
        .subscribe(onNext: { print($0) })
}

//:>每次有新的观察者订阅后都会得到全部的Observable Sequences

//:![Create](RxSwift_Empty.png)

run("Empty") {
    Observable<String>
        .empty()
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![Create](RxSwift_Never.png)

run("Never") { 
    Observable<String>
        .never()
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:>没有结束事件被抛出

//:![Create](RxSwift_Throw.png)

run("Error") {
    let error = NSError(domain: "playground",
                        code: 404,
                        userInfo: ["key":"description"])
    Observable<String>
        .error(error)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//: > calling failWith() before

//:![Create](RxSwift_Just.png)

run("Just") { 
    Observable.just("🐶")
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:>仅能转换一个元素

//:![Create](RxSwift_From.png)

run("From") { 
    Observable
        .from(["🐶", "🐱", "🐵"])
//        .of("🐶", "🐱", "🐵")
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:>这两个方法功能一样，将一个或多个可以转换为Observalbe的对象生成Sequences

//:![Create](RxSwift_Repeat.png)

run("Repeat") {
    Observable
        .repeatElement("🐶")
        .take(10)
        .subscribe({print("Repeat:\($0)")})
        .addDisposableTo(disposeBag)
}

//:![Create](RxSwift_Range.png)

run("Range") { 
    Observable<Int>
        .range(start: 0, count: 9)
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:>closed range, such as 0..>9

//:![Create](RxSwift_Interval.png)

run("Interval", duration: 10) {
    Observable<Int>
        .interval(1, scheduler: MainScheduler.instance)
        .subscribe({print("Interval:" + "\($0)")})
        .addDisposableTo(disposeBag)
}

//:![Create](RxSwift_Timer.png)

run("Timer", duration: 10) { 
    Observable<Int>
        .timer(6, scheduler: MainScheduler.instance)
        .subscribe({print("Time Up:" + "\($0)")})
        .addDisposableTo(disposeBag)
}

//: [Transforming](@next)
