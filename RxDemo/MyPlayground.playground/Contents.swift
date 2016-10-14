//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var str = "Hello, playground"

let list: [String] = ["http://google.com", "http://163.com"]
let urls = list.map { url_string -> URL? in
    return URL(string: url_string)
}

print(type(of:urls[0]!))