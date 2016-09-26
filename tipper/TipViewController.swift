//
//  ViewController.swift
//  tipper
//
//  Created by Edwin Wong on 9/24/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, TipperUpdateProtocol, UITextFieldDelegate {

    // MARK: View properties
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // MARK: internal properties
    private var tipPercentages: [Double] = [0.15, 0.2, 0.25]
    
    //MARK: default methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSavedBillAndTipIndex()
        // Do any additional setup after loading the view, typically from a nib.
        updateTipper() // update segmented tip control and update tip when entering view (in case settings tip% changes)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: events
    
    // on screen tap, hide keyboard, save bill and tip index
    @IBAction func onTap(_ sender: AnyObject) {
        // force keyboard hide
        view.endEditing(true)
        saveBillAndTipIndex()
    }
    
    // Update tip values when entering bill
    @IBAction func calculateTip(_ sender: AnyObject) {
        calculateTipInternal()
    }
    
    
    
    @IBAction func changeTipAction(_ sender: AnyObject) {
        if !UserSettingsService.service.saveTipPercentControlIndex(index: tipControl.selectedSegmentIndex){
            print("Error: unable to save index")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showSettings"){
            if let view = segue.destination as? SettingsTableViewController{
                view.tipperUpdateDelgate = self            }
        }
    }
    
    // show keyboard when view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // to allow keyboard as first responder
        billField.delegate = self
        billField.becomeFirstResponder()
    }

    // MARK: delegate methods
    
    // allow Settings Controller to fire updateProtocol
    func updateTipper() {
        updateTipControl()
        calculateTipInternal()
    }

    // MARK: private methods
    
    // Load saved bill and tipping index from UserSettings
    // Update UI to reflect state
    private func loadSavedBillAndTipIndex(){
        let bill: Double = UserSettingsService.service.getBill()
        let tippingPercentIndex: Int = UserSettingsService.service.getTipPercentControlIndex()
        
        //let formatter = NumberFormatter()
        //formatter.minimum = 0
        //formatter.minimumFractionDigits=0
        //formatter.numberStyle = .currency
        //billField.text = formatter.string(from: NSNumber(value: bill))
        billField.text = (bill != 0 ? String(format: "%.2f", bill): "")
        tipControl.selectedSegmentIndex = tippingPercentIndex
    }
    
    private func saveBillAndTipIndex(){
        let bill = Double(billField.text!) ?? 0
        let tipIndex = tipControl.selectedSegmentIndex
        
        if !UserSettingsService.service.saveBill(value: bill) ||
            !UserSettingsService.service.saveTipPercentControlIndex(index: tipIndex){
            print("Error has occurred with saving Bill or Tip Index")
        }
    }
    
    // Fetch tip percentage from service and update the segmented control
    private func updateTipControl(){
        let tippingPercentageArr:[Int] = UserSettingsService.service.getTippingPercentages()
        for (index, element) in tippingPercentageArr.enumerated(){
            let percentage = "\(element)%"
            tipControl.setTitle(percentage, forSegmentAt: index)
            tipPercentages[index] = Double(element)*0.01 // convert integer to double
        }
    }
    
    // Calculate tip and update view
    private func calculateTipInternal(){
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
    }
    
    
}

