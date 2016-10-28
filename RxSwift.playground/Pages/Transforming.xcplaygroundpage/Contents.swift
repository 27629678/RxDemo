//: [Previous Chapter: Creating](@previous)

import RxSwift
import Foundation

let disposeBag = DisposeBag()

//:![Transforming](RxSwift_Buffer.png)

run("Buffer") { 
    Observable
        .generate(initialState: "0",
                  condition: { $0.characters.count < 3 },
                  iterate: { String(Int($0)! + 1) })
        .buffer(timeSpan: 1,
                count: 5,
                scheduler: MainScheduler.instance)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

//:>Buffer最大缓冲区为5个元素，最长收集时间为1秒，即若1秒内未抛出5个元素，则直接抛出当前缓冲区内的所有元素，即使当前仅包含0个元素的时候；

//:![Transforming](RxSwift_Map.png)

run("Map") { 
    Observable.generate(initialState: 0,
                        condition: { $0 < 10 },
                        iterate: { $0 + 1 })
        .map({ (number) -> String in
            return "String:" + String(number)
        })
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![Transforming](RxSwift_FlatMap.png)

run("FlatMap") { 
    Observable
        .generate(initialState: "0",
                  condition: { $0.characters.count < 2 },
                  iterate: { String(Int($0)! + 1) })
        .buffer(timeSpan: 3,
                count: 5,
                scheduler: MainScheduler.instance)
        .flatMap({ (list:[String]) -> Observable<String> in
            if list.count > 0 {
                return Observable.from(list)
            }
            
            return Observable.empty()
        })
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
}

//:![Transforming](RxSwift_Scan.png)

run("Scan") {
    Observable<Int>
        .range(start: 0, count: 10)
        .scan(10, accumulator: { (seed, number) -> Int in
            return seed + number
        })
        .subscribe({print($0)})
        .addDisposableTo(disposeBag)
    
}

//:![Transforming](RxSwift_Window.png)

run("Window") { 
    Observable<Int>
        .range(start: 0, count: 10)
        .window(timeSpan: 1,
                count: 3,
                scheduler: MainScheduler.instance)
//        .flatMap({$0})
        .subscribe(onNext: { (observer) in
            print(observer)
            observer
                .subscribe({print($0)})
                .addDisposableTo(disposeBag)
        })
        .addDisposableTo(disposeBag)
}

//:>还没有找到使用场景，可能与分组处理有关；注意与**Buffer**的区别

//: [Next Chapter: Filtering](@next)
