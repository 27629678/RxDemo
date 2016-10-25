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
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        `switch`.rx.value
            .subscribe(onNext: { [weak self] in self?.switchBtnAction(sender: $0)} )
            .addDisposableTo(disposeBag)
    }

    func switchBtnAction(sender: Any) {
        print(sender)
    }
}
