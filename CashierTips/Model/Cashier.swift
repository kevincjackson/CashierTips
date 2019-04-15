//
//  Cashier.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/4/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class Cashier: NSObject {
    
    var name: String
    var hoursWorked: Double
    
    init(name: String, hoursWorked: Double) {
        self.name = name
        self.hoursWorked = hoursWorked
    }

    public func getTipsDescribed(rate: Double) -> String {
        let tips = hoursWorked * rate
        return String(format: "$%.2f", tips)
    }
    
}
