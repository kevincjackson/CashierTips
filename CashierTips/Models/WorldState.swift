//
//  WorldState.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/15/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct WorldState: Codable {
    
    // MARK: - Stored properties
    var totalTips: Double = 0.0
    var cashiers = [Cashier]()

    // MARK: Computed Properties
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
}
