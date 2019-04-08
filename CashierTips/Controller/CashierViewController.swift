//
//  CashierViewController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/6/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class CashierViewController: UIViewController {
    
    // Stored Properties
    // Picker Properties
    let hours: [String] = Array(0...23).map { String($0) }
    let subHours: [String] = Constants.ZeroToNinetyNinePadded
    
    // Cashier Properties
    var name: String?
    var hoursWorked: Double?
    
    // Delegates
    var delegate: CashierDelegate?
    
    // View Pointers
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up hours pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // MARK: - Target-Actions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cashierUpdated(name: name ?? "?", hoursWorked: hoursWorked ?? 0)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - Cashier Delegate
protocol CashierDelegate {
    func cashierUpdated(name: String, hoursWorked: Double)
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



