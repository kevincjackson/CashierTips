//
//  TotalTipsController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/6/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

protocol TipViewDelegate {
    func tipAmountUpdated(amount: Double)
}

class TipViewController: UIViewController {
    
    let dollarOptions: [String] = Array(0...999).map { String($0) }
    let centOptions: [String] = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
    var selectedAmount: Double?
    var delegate: TipViewDelegate?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        
        if let selectedAmount = selectedAmount {
            let dollars = Int(selectedAmount)
            let cents = Int(selectedAmount * 100) % 100
            pickerView.selectRow(dollars, inComponent: 1, animated: false)
            pickerView.selectRow(cents, inComponent: 3, animated: false)
        }
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let amount: Double = selectedAmount ?? 0
        delegate?.tipAmountUpdated(amount: amount)
        dismiss(animated: true, completion: nil)
    }
}

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
