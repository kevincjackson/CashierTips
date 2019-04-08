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
    
    init(name: String, hoursWorked: Double) {
        self.name = name
        self.hoursWorked = hoursWorked
    }
    
    private func getTips(rate: Double) -> Double {
        return hoursWorked * rate
    }
    
    private func getTipsDescribed(rate: Double) -> String {
        let tips = getTips(rate: rate)
        return String(round(tips * 100) / 100)
    }
    
}
