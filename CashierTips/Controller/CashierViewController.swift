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
    var cashier: Cashier?
    var isNew = false
    let hoursOptions: [String] = Array(0...23).map { String($0) }
    let subHoursOptions: [String] = Constants.ZeroToNinetyNinePadded
    
    // Computed Properties
    var nameEntered: String {
        var name: String
        if let nameEntered = textField.text, !nameEntered.isEmpty {
            name = nameEntered
        }
        else {
            name = "?"
        }
        return name
    }
    var hoursSelected: Double {
        let hrs = pickerView.selectedRow(inComponent: 0)
        let subhrs = pickerView.selectedRow(inComponent: 2)
        return Double("\(hrs).\(subhrs)")!
    }
    
    // Delegates
    var delegate: CashierDelegate?
    
    // View Pointers
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Set new / edit flag
        isNew = (cashier == nil)

        // Set up hours pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // MARK: - Target-Actions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let cashier = Cashier(name: nameEntered, hoursWorked: hoursSelected)
        delegate?.cashierUpdated(cashier: cashier, isNew: isNew)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - Cashier Delegate
protocol CashierDelegate {
    func cashierUpdated(cashier: Cashier, isNew: Bool)
}


// MARK: - Picker DataSource
extension CashierViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hoursOptions.count
        }
        else if component == 1 {
            return 1
        }
        else if component == 2 {
            return subHoursOptions.count
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
            return hoursOptions[row]
        }
        else if component == 1 {
            return "."
        }
        else if component == 2 {
            return subHoursOptions[row]
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
}



