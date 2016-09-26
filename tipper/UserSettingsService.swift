//
//  UserSettingsService.swift
//  tipper
//
//  Created by Edwin Wong on 9/25/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import Foundation

class UserSettingsService{
    
    static let service = UserSettingsService()
    
    let tippingPercentagesKeys : [String] = ["tipPercentFirst", "tipPercentSecond", "tipPercentThird"]
    
    let billKey: String = "billKey" // for the bill
    let tipPercentControlIndexKey: String = "tipPercentControlIndexKey" // for the tip % segmented control
    
    let lastDateTimeKey: String = "lastDateTimeKey" // for determining when the user last opened the app
    
    private init(){
        let defaults = UserDefaults.standard
        
        if defaults.integer(forKey: tippingPercentagesKeys[0]) == 0{
            defaults.set(15, forKey: tippingPercentagesKeys[0])
        }
        if defaults.integer(forKey: tippingPercentagesKeys[1]) == 0{
            defaults.set(20, forKey: tippingPercentagesKeys[1])
        }
        if defaults.integer(forKey: tippingPercentagesKeys[2]) == 0{
            defaults.set(25, forKey: tippingPercentagesKeys[2])
        }
        
        if defaults.double(forKey: billKey) == 0{
            defaults.set(0, forKey: billKey)
        }
        if defaults.integer(forKey: tipPercentControlIndexKey) == 0{
            defaults.set(0, forKey: tipPercentControlIndexKey)
        }
        
        if defaults.object(forKey: lastDateTimeKey) == nil{
            defaults.set(NSDate.timeIntervalSinceReferenceDate, forKey: lastDateTimeKey)
        }
    }
    
    // get array of tipping percentages as [Int]
    // in the form [first, second, third]
    func getTippingPercentages() -> [Int]{
        let defaults = UserDefaults.standard
        var tippingPercentageArr:[Int] = []
        // get keys and save
        for key in tippingPercentagesKeys{
            let value = defaults.integer(forKey: key)
            tippingPercentageArr.append(value)
        }
        return tippingPercentageArr
    }
    
    // saves value for an index representing (first, second, or third tipping percentages)
    // returns true for success and false for failure
    func saveTippingPercentage(index: Int, value: Int) -> Bool{
        if index >= 0 && index < 3 && value > 0{
            let defaults = UserDefaults.standard
            defaults.set(value, forKey: tippingPercentagesKeys[index])
            return true
        }else{
            return false
        }
    }
    
    // Get segmented control index to decide first, second, third tipping %
    func getTipPercentControlIndex() -> Int{
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: tipPercentControlIndexKey)
    }
    
    // Get saved bill
    func getBill() -> Double{
        let defaults = UserDefaults.standard
        return defaults.double(forKey: billKey)
    }
    
    // Save tipPercentControlIndexKey
    func saveTipPercentControlIndex(index: Int) -> Bool{
        if(index >= 0){
            let defaults = UserDefaults.standard
            defaults.set(index, forKey: tipPercentControlIndexKey)
            return true
        }else{
            return false
        }
    }
    
    // Save Bill
    func saveBill(value: Double) -> Bool{
        if(value >= 0){
            let defaults = UserDefaults.standard
            defaults.set(value, forKey: billKey)
            return true
        }else{
            return false
        }
    }
    
    // save current time
    func saveTime(){
        let defaults = UserDefaults.standard
        defaults.set(NSDate.timeIntervalSinceReferenceDate, forKey: lastDateTimeKey)
    }
    
    // get last date time
    func getTime() -> TimeInterval{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: lastDateTimeKey) as! TimeInterval
    }
    
}
