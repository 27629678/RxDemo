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
        titles.append("Login")
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
        var target: UIViewController?
        let title = titles[indexPath.row]
        
        if title == "Caculator" {
            target = storyboard?.instantiateViewController(withIdentifier: "CaculatorViewController")
        }
        else if title == "Login" {
            target = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        }
        
        guard let viewcontroller = target else {
            return
        }
        
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }

}

