//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var str = "Hello, playground"

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let subject2 = PublishSubject<String>()

Observable.of(subject, subject2).merge().subscribe({ print("A:\($0.element)") })
Observable.of(subject, subject2).switchLatest().subscribe({ print("B:\($0.element)") })

Observable.zip(subject, subject2) { $0 + $1 }.subscribe { (event) in
    print("C:\(event.element)")
}
Observable.combineLatest(subject, subject2) { $0 + $1 }.subscribe({ print("D:\($0)") })

subject.onNext("a")
subject.onNext("c")
subject2.onNext("b")