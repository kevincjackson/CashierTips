//
//  CashierViewController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/6/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

protocol CashierDelegate {
    func cashierUpdated(name: String, hoursWorked: Double)
}

class CashierViewController: UIViewController {
    
    // Picker Options
    let hours: [String] = Array(0...23).map { String($0) }
    let subHours: [String] = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
    
    // Cashier Hours Worked
    var name: String?
    var hoursWorked: Double?
    
    // Delegates
    var delegate: CashierDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up hours pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // MARK: - Functions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cashierUpdated(name: name ?? "?", hoursWorked: hoursWorked ?? 0)
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - Picker DataSource
extension CashierViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hours.count
        }
        else if component == 1 {
            return 1
        }
        else if component == 2 {
            return subHours.count
        }
        else {
            return 1
        }
    }
}

// MARK: - Picker Delegate
extension CashierViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return hours[row]
        }
        else if component == 1 {
            return "."
        }
        else if component == 2 {
            return subHours[row]
        }
        else {
            return "hours"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 100
        }
        else if component == 1 {
            return 20
        }
        else if component == 2 {
            return 100
        }
        else {
            return 100
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let hrs = hours[pickerView.selectedRow(inComponent: 0)]
        let sub = subHours[pickerView.selectedRow(inComponent: 2)]
        
        hoursWorked =  Double("\(hrs).\(sub)")
    }
}
