//
//  FormatUtility.swift
//  tipper
//
//  Created by Edwin Wong on 9/26/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import Foundation

class FormatUtility{
    
    static private var currencyFormatter: NumberFormatter {
        get{
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            return  formatter
        }
    }
    
    static private var decimalFormatter: NumberFormatter {
        get{
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            return  formatter
        }
    }
    
    // convert NSNumber to currency as a string
    static func numberToCurrencyString(value:NSNumber) -> String?{
        let test =  currencyFormatter.string(from: value)
        return test
    }
    
    // convert a string currency to a NSNumber
    static func currencyStringToNumber(word: String) -> NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let test = formatter.number(from: word)
        return test
    }
    
    // convert a string with fractional digits to Double
    static func numberStringToDecimal(word: String) -> Double?{
        let number = decimalFormatter.number(from: word)
        return number?.doubleValue
    }
    
    // convert double to string
    static func decimalToString(value: Double) -> String{
        return decimalFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}
