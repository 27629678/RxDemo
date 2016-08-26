//
//  CaculatorViewController.swift
//  RxDemo
//
//  Created by hzyuxiaohua on 8/26/16.
//  Copyright © 2016 hzyuxiaohua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CaculatorViewController: UIViewController {

    @IBOutlet weak var num1: UITextField!
    @IBOutlet weak var num2: UITextField!
    @IBOutlet weak var num3: UITextField!
    @IBOutlet weak var sum: UITextField!
    
    var disposeBag: DisposeBag?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Caculator"
        
        self.disposeBag = DisposeBag()
        
        // Do any additional setup after loading the view.
//        Observable.combineLatest(num1.rx_text, num2.rx_text, num3.rx_text) { (text1, text2, text3) -> Int in
//            return (Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0)
//        }
//        .map { $0.description }
//        .bindTo(sum.rx_text)
//        .addDisposableTo(self.disposeBag!)
        
//        Observable.zip(num1.rx_text, num2.rx_text, num3.rx_text) { (text1, text2, text3) -> Int in
//            return (Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0)
//        }
//        .map { (num) -> String in
//            return num.description
//        }
//        .bindTo(sum.rx_text)
//        .addDisposableTo(self.disposeBag!)
        
        let source = Observable.range(start: 0, count: 3)
        let result = source.startWith(-3, -2, -1)
        result.subscribe { (event) in
            if let num = event.element {
                print(num)
            }
        }
    }

}
