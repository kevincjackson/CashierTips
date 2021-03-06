//
//  Cashier.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/4/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct Cashier: Codable {

    var name: String
    var hoursWorked: Double
    
    init(name: String, hoursWorked: Double) {
        self.name = name
        self.hoursWorked = hoursWorked
    }

    public func calculateTips(usingRate rate: Double) -> Double {
        return hoursWorked * rate
    }
    
}
