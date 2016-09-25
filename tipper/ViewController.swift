//
//  ViewController.swift
//  tipper
//
//  Created by Edwin Wong on 9/24/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: properties
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    private let tipPercentages = [0.15, 0.2, 0.25]
    
    //MARK: default methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: events
    
    // on screen tap, hide keyboard
    @IBAction func onTap(_ sender: AnyObject) {
        // force keyboard hide
        //view.endEditing(true)
    }
    
    // Update tip values when entering bill
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
    }
    
    
    
}

