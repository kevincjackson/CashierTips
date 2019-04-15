//
//  WorldState.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/15/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class WorldState {
    
    // Stored properties
    var totalTips: Double = 0.0
    var cashiers = [Cashier]()
    var sections = ["Total Tips", "Cashiers"]
    
    // Computed Properties
    var tipRate: Double {
        return totalHoursWorked != 0 ? totalTips / totalHoursWorked : 0
    }
    var totalHoursWorked: Double {
        return cashiers.reduce(0) { $0 + $1.hoursWorked }
    }
    var totalTipsDescription: String {
        let thw = String(format: "%.2f", totalHoursWorked)
        let tr = String(format: "%.3f", tipRate)
        return "Total Hours: \(thw), Tip Rate: \(tr)"
    }
    
    public func addCashier(cashier: Cashier) {
        cashiers.append(cashier)
    }
    
    public func removeCashier(cashier: Cashier) {
        guard let index = cashiers.firstIndex(of: cashier) else {
            return
        }
        cashiers.remove(at: index)
    }
    
    public func moveCashier(from a: Int, to b: Int) {
        let cashier = cashiers[a]
        cashiers.remove(at: a)
        cashiers.insert(cashier, at: b)
    }
}
