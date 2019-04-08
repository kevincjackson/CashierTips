//
//  Cashier.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/4/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class Cashier {
    
    var name: String
    var hoursWorked: Double
    var tipRate: Double? {
        didSet {
            tipAmount = tipRate! * hoursWorked
            tipAmountDescription = String(round(tipAmount! * 100) / 100)
        }
    }
    var tipAmount: Double?
    var tipAmountDescription: String?
    
    init(name: String, hoursWorked: Double) {
        self.name = name
        self.hoursWorked = hoursWorked
    }
    
}
