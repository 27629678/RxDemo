//
//  ViewController.swift
//  RxDemo
//
//  Created by hzyuxiaohua on 8/26/16.
//  Copyright © 2016 hzyuxiaohua. All rights reserved.
//

import UIKit

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
    }

    // MARK: table view delegate and datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("RxDemos")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "RxDemos")
        }
        
        cell?.textLabel?.text = titles[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if titles[indexPath.row] == "Caculator" {
            let target = storyboard?.instantiateViewControllerWithIdentifier("CaculatorViewController")
            self.navigationController?.pushViewController(target!, animated: true)
        }
    }

}

