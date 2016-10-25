//
//  SearchViewController.swift
//  RxDemo
//
//  Created by hzyuxiaohua on 2016/10/25.
//  Copyright © 2016年 hzyuxiaohua. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    let disposeBag = DisposeBag()
    var myDisposable: Disposable? = nil
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // bind switch action
        `switch`.rx.value
            .subscribe(onNext: { [weak self] in self?.switchBtnAction(isOn: $0)} )
            .addDisposableTo(disposeBag)
    }

    func switchBtnAction(isOn: Bool) {
        input.text = ""
        textView.text = ""
        myDisposable?.dispose()
        
        if isOn {
            textView.text.append("throttle")
            myDisposable = input.rx.text
                .throttle(1, scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] in self?.handle($0) })
        }
        else {
            textView.text.append("debounce")
            myDisposable = input.rx.text
                .debounce(1, scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] in self?.handle($0) })
        }
        
        myDisposable?.addDisposableTo(disposeBag)
    }
    
    func handle(_ keyword: String?) {
        textView.text.append("\n"+String(Int(Date().timeIntervalSince1970))+":"+keyword!)
    }
}
