//
//  CurrencyFormatter.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 07/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import Foundation

class CurrencyFormatter{
    static func format(_ money:Int)->String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.groupingSeparator = "."

        let priceString = currencyFormatter.string(from: NSNumber(value: Double(money)))!
        return "Rp. \(priceString)"
    }
}
