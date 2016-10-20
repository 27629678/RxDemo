//
//  LoginViewController.swift
//  RxDemo
//
//  Created by hzyuxiaohua on 2016/10/20.
//  Copyright © 2016年 hzyuxiaohua. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var atip: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btip: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Observable
            .combineLatest(username.rx.text, password.rx.text) { (username, password) -> Bool in
                return username.characters.count > 4 && password.characters.count > 5
            }
            .bindTo(loginBtn.rx.enabled)
            .addDisposableTo(disposeBag)
        
        username.rx.text
            .map { $0.characters.count > 4}
            .bindTo(atip.rx.hidden)
            .addDisposableTo(disposeBag)
        
        password.rx.text
            .map { $0.characters.count > 5 }
            .bindTo(btip.rx.hidden)
            .addDisposableTo(disposeBag)
        
        loginBtn.rx.tap
            .subscribe(onNext: { [weak self] in self?.showAlert() })
            .addDisposableTo(disposeBag)
    }
    
    private func showAlert() {
        let avc = UIAlertController(title: "Confirm",
                                    message: "login using account \(username.text!) ?",
                                    preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        avc.addAction(cancel)
        
        present(avc, animated: true, completion: nil)
    }

}
