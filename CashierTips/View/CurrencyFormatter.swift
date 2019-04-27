//
//  CurrencyFormatter.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/19/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class CurrencyFormatter  {

    private static let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = NumberFormatter.Style.currency
        return nf
    }()

    public func stringFrom(double: Double) -> String {
        return CurrencyFormatter.numberFormatter.string(from: NSNumber(value: double))!
    }
}
