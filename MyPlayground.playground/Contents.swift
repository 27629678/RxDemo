//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var array: [String] = ["1", "2", "three", "4", "//5//"]

let list0: [Int?] = array.map { (item) -> Int? in
    return Int(item)
}
print(list0)

print(array.map { Int($0) })

print(array.flatMap { Int($0) })

print(array.flatMap ({ (item) -> Int? in
    return Int(item)
}))

let list1: [Int?] = array.flatMap { Int($0) }
print(list1)

let list2: [Int?] = array.flatMap({ (item) -> Int? in
    return Int(item)
})
print(list2)

func myPrint(_ item: String)
{
    print("T:\(type(of:item)), V:\(item)")
}

let a: String? = nil

a.map(myPrint)
a.flatMap(myPrint)

let 名字: String = "name"

print(名字)
