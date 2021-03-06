//
//  ViewController.swift
//  Doge Tips
//
//  Created by Daniel Noskin on 6/2/15.
//  Copyright (c) 2015 Daniel Noskin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var billAmount: UILabel!
    @IBOutlet weak var tipPercentage: UILabel!
    @IBOutlet weak var billAmountSlider: UISlider!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var dogeImage: UIImageView!
    
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let colorWheel = ColorWheel()
    let dogeSayings = DogeSayings()
    var totalCostGlobal: Double = 0.00
    var billAmountGlobal: Double = 0.00
    var tipPercentageGlobal: Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == true, animated: false)
        
        totalCost.textColor = self.colorWheel.randomColor()
        billAmount.textColor = self.colorWheel.randomColor()
        tipPercentage.textColor = self.colorWheel.randomColor()
        billAmountSlider.minimumTrackTintColor = self.colorWheel.randomColor()
        tipPercentageSlider.minimumTrackTintColor = self.colorWheel.randomColor()
        dogeImage.alpha = 0
        
        if defaults.objectForKey("time") == nil{
            defaults.setObject(["1/1/15 00:00"], forKey: "time")
            defaults.setObject([0.00], forKey: "totalCost")
            defaults.setObject([0.00], forKey: "tipPercentage")
            defaults.synchronize()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func billAmountChanged(sender: UISlider) {
        let billAmountDecimal = String(format: "%.2f", sender.value)
        billAmount.text = "Bill Amount: $\(billAmountDecimal)"
        billAmountGlobal = (billAmountDecimal as NSString).doubleValue
        
        calculateTotalCost()
    }
    
    @IBAction func tipPercentageChanged(sender: UISlider) {
        let tipPercentageDecimal = String(format: "%.2f", sender.value)
        tipPercentage.text = "Tip: \(tipPercentageDecimal)%"
        tipPercentageGlobal = (tipPercentageDecimal as NSString).doubleValue
        
        calculateTotalCost()
    }
    
    func calculateTotalCost(){
        let totalCostAmount = billAmountGlobal + ((tipPercentageGlobal/100) * billAmountGlobal)
        totalCostGlobal = totalCostAmount
        let totalCostAmountDecimal = String(format: "%.2f", totalCostAmount)
        totalCost.text = "Total Cost: $\(totalCostAmountDecimal)"
        
        let billMax = String(format: "%.2f", billAmountSlider.maximumValue)
        let billMaxDecimal = (billMax as NSString).doubleValue
        let tipMax = String(format: "%.2f", tipPercentageSlider.maximumValue)
        let tipMaxDecimal = (tipMax as NSString).doubleValue
        dogeImage.alpha = (CGFloat(billAmountGlobal / billMaxDecimal) + CGFloat(tipPercentageGlobal / tipMaxDecimal)) / 2
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let width = UInt32(screenSize.width)
        let height = UInt32(screenSize.height)
        
        let randomNumber1 = CGFloat(arc4random_uniform(width))
        let randomNumber2 = CGFloat(arc4random_uniform(height/2))
        
        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(randomNumber1, randomNumber2)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = self.colorWheel.randomColor()
        label.text = self.dogeSayings.randomDoge()
        label.tag = 50
        self.view.addSubview(label)
    }
    
    @IBAction func saveMe(sender: AnyObject) {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm"
        let stringDate: String = formatter.stringFromDate(NSDate())
        
        var timeDefault = defaults.arrayForKey("time")
        var totalCostDefault = defaults.arrayForKey("totalCost")
        var tipPercentageDefault = defaults.arrayForKey("tipPercentage")
        
        timeDefault?.append(stringDate)
        totalCostDefault?.append(totalCostGlobal)
        tipPercentageDefault?.append(tipPercentageGlobal)
        
        defaults.setObject(timeDefault, forKey: "time")
        defaults.setObject(totalCostDefault, forKey: "totalCost")
        defaults.setObject(tipPercentageDefault, forKey: "tipPercentage")
        defaults.synchronize()
        
        clearMe(sender)
    }
    
    @IBAction func clearMe(sender: AnyObject) {
        totalCost.text = "Total Cost: $0.00"
        billAmount.text = "Bill Amount: $0.00"
        tipPercentage.text = "Tip: 0.00%"
        billAmountSlider.value = 0
        tipPercentageSlider.value = 0
        dogeImage.alpha = 0
        
        let labels = getLabelsInView(self.view)
        for label in labels {
            if label.tag == 50{
                label.removeFromSuperview()
            }
        }
    }
    
    func getLabelsInView(view: UIView) -> [UILabel] {
        var results = [UILabel]()
        for subview in view.subviews {
            if let labelView = subview as? UILabel {
                results += [labelView]
            } else {
                results += getLabelsInView(subview)
            }
        }
        return results
    }
}

