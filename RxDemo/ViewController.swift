//
//  ViewController.swift
//  RxDemo
//
//  Created by hzyuxiaohua on 8/26/16.
//  Copyright © 2016 hzyuxiaohua. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "RxDemos"
        
        titles.append("Caculator")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        _ = Observable<Int>
            .timer(0.1, period: 0.1, scheduler: MainScheduler.instance)
            .take(10)
            .subscribe(onNext: { print("timer:\($0)") })
    }

    // MARK: table view delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RxDemos")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "RxDemos")
        }
        
        cell?.textLabel?.text = titles[(indexPath as NSIndexPath).row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if titles[(indexPath as NSIndexPath).row] == "Caculator" {
            let target = storyboard?.instantiateViewController(withIdentifier: "CaculatorViewController")
            self.navigationController?.pushViewController(target!, animated: true)
        }
    }

}

