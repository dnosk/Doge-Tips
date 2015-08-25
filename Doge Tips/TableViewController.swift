//
//  TableViewController.swift
//  Doge Tips
//
//  Created by Daniel Noskin on 8/24/15.
//  Copyright © 2015 Daniel Noskin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let colorWheel = ColorWheel()
    var time: [String] = []
    var totalCost: [Double] = []
    var tipPercentage: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.arrayForKey("time") != nil {
            time = (defaults.objectForKey("time") as? Array)!
        }
        
        if defaults.arrayForKey("totalCost") != nil {
            totalCost = (defaults.objectForKey("totalCost") as? Array)!
        }
        
        if defaults.arrayForKey("tipPercentage") != nil {
            tipPercentage = (defaults.objectForKey("tipPercentage") as? Array)!
        }
        
        print(defaults)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        cell.backgroundColor = colorWheel.randomColor()
        cell.textLabel?.tintColor = UIColor.whiteColor()
        
        let totalCostAmountDecimal = String(format: "%.2f", totalCost[indexPath.row])
        
        cell.timeLabel.text = time[indexPath.row]
        cell.totalCostLabel.text = "$ \(totalCostAmountDecimal)"
        cell.tipPercentageLabel.text = "\(tipPercentage[indexPath.row])%"

        return cell
    }
}
