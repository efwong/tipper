//
//  SettingsTableViewController.swift
//  tipper
//
//  Created by Edwin Wong on 9/25/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: View properties
    @IBOutlet weak var firstTippingPercent: UITextField!

    @IBOutlet weak var secondTippingPercent: UITextField!
    
    @IBOutlet weak var thirdTippingPercent: UITextField!
    
    // MARK: Internal properties
    weak var tipperUpdateDelgate: TipperUpdateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Settings"
        
        updatePercentagesView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // save settings whenleaving page
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(self.isMovingFromParentViewController){
            // save percentages and update tipper view in main controller
            savePercentages()
            tipperUpdateDelgate?.updateTipper()
        }
    }
    
    
    
    // MARK: private methods
    
    // save textbox percentages to UserSettings
    private func savePercentages(){
        let first:Int? = Int(firstTippingPercent.text!) ?? 0
        let second:Int? = Int(secondTippingPercent.text!) ?? 0
        let third:Int? = Int(thirdTippingPercent.text!) ?? 0
        
        if !UserSettingsService.service.saveTippingPercentage(index: 0, value: first!) ||
            !UserSettingsService.service.saveTippingPercentage(index: 1, value: second!) ||
            !UserSettingsService.service.saveTippingPercentage(index: 2, value: third!){
            print("Error unable to save")
        }
    }
    
    private func updatePercentagesView(){
        let tippingPercentagesArr: [Int] = UserSettingsService.service.getTippingPercentages()
        guard tippingPercentagesArr.count > 2 else{
            print("Error invalid percentage array found in UserSettings")
            return
        }
        
        firstTippingPercent.text = String(format:"%d",tippingPercentagesArr[0])
        secondTippingPercent.text = String(format:"%d",tippingPercentagesArr[1])
        thirdTippingPercent.text = String(format:"%d",tippingPercentagesArr[2])
    }
    
    

}
