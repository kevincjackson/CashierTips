//
//  TotalTipsController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/6/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    let dollarOptions: [String] = Array(0...999).map { String($0) }
    let centOptions: [String] = Constants.ZeroToNinetyNinePadded
    var selectedAmount: Double?
    weak var delegate: TipViewDelegate?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedAmount = selectedAmount {
            let dollars = Int(selectedAmount)
            let cents = Int(selectedAmount * 100) % 100
            pickerView.selectRow(dollars, inComponent: 1, animated: false)
            pickerView.selectRow(cents, inComponent: 3, animated: false)
        }
    }

    // MARK: - Target-Actions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let amount: Double = selectedAmount ?? 0
        dismiss(animated: true, completion: {
            self.delegate?.tipAmountUpdated(amount: amount)
        })
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - TipViewDelegate
protocol TipViewDelegate: AnyObject {
    func tipAmountUpdated(amount: Double)
}

// MARK: - Picker View
extension TipViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return 1
        }
        else if component == 1 {
            return dollarOptions.count
        }
        else if component == 2 {
            return 1
        }
        else {
            return centOptions.count
        }
    }
}

extension TipViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return "$"
        }
        else if component == 1 {
            return dollarOptions[row]
        }
        else if component == 2 {
            return "."
        }
        else {
            return centOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dlr = dollarOptions[pickerView.selectedRow(inComponent: 1)]
        let cnt = centOptions[pickerView.selectedRow(inComponent: 3)]
        
        selectedAmount = Double("\(dlr).\(cnt)")
    }
}
