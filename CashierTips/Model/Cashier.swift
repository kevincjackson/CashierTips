//
//  Cashier.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/4/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct Cashier {
    
    var name: String
    var hoursWorked: Double
    
    init(name: String, hoursWorked: Double) {
        self.name = name
        self.hoursWorked = hoursWorked
    }
    
    private func getTips(rate: Double) -> Double {
        return hoursWorked * rate
    }
    
    public func getTipsDescribed(rate: Double) -> String {
        let tips = getTips(rate: rate)
        let tipsRounded = round(tips * 100) / 100
        return "$\(tipsRounded)"
    }
    
}
