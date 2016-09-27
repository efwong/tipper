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
    @IBOutlet weak var currencySymbol: UILabel!
    
    // MARK: internal properties
    private var tipPercentages: [Double] = [0.15, 0.2, 0.25]
    
    //MARK: default methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSavedBillAndTipIndex()
        // Do any additional setup after loading the view, typically from a nib.
        updateTipper() // update segmented tip control and update tip when entering view (in case settings tip% changes)
        
        // load currency symbol
        let locale = Locale.current
        currencySymbol.text = locale.currencySymbol
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: events
    
    // Update tip values when typing bill into billField
    // save bill to UserSettings
    @IBAction func calculateTip(_ sender: AnyObject) {
        updateTipView()
        saveBill()
    }
    
    
    // Fires when user changes the tip percent segmented control
    // updates the saved tip % and the generated tips and total fields
    @IBAction func changeTipAction(_ sender: AnyObject) {
        if !UserSettingsService.service.saveTipPercentControlIndex(index: tipControl.selectedSegmentIndex){
            print("Error: unable to save index")
        }
        updateTipView()
    }
    
    // Fires when user attempts to navigate to Settings view
    // passes delegate information to Settings view
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
        updateTipControl() // save tip index
        updateTipView()
    }

    // MARK: private methods
    
    // Load saved bill and tipping index from UserSettings
    // Update UI to reflect state
    private func loadSavedBillAndTipIndex(){
        let bill: Double = UserSettingsService.service.getBill()
        // if bill == 0, then just ignore it and leave textfield empty
        let billString = (bill != 0) ? FormatUtility.decimalToString(value: bill) : ""
        let tippingPercentIndex: Int = UserSettingsService.service.getTipPercentControlIndex()
        billField.text = billString
        tipControl.selectedSegmentIndex = tippingPercentIndex
    }
    
    // save bill to UserSettings
    private func saveBill(){
        let bill = FormatUtility.numberStringToDecimal(word: billField.text!) ?? 0
        if !UserSettingsService.service.saveBill(value: bill) {
            print("Error: unable to save bill")
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
    private func updateTipView(){
        let bill = FormatUtility.numberStringToDecimal(word: billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = FormatUtility.numberToCurrencyString(value: tip as NSNumber) ?? ""
        totalLabel.text = FormatUtility.numberToCurrencyString(value: total as NSNumber) ?? ""
    }
    
    
}

