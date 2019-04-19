//
//  CashierViewController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/6/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class CashierViewController: UIViewController {
    
    // View Pointers
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    // Stored Properties
    var cashier: Cashier?
    var cashierIndex = 0
    var isNew = false
    let hoursOptions: [String] = Array(0...23).map { String($0) }
    let subHoursOptions: [String] = Constants.ZeroToNinetyNinePadded
    
    // Computed Properties
    var nameEntered: String {
        guard let nameEntered = textField.text, !nameEntered.isEmpty else {
            return "?"
        }
        return nameEntered
    }
    var hoursSelected: Double {
        let hrs = hoursOptions[pickerView.selectedRow(inComponent: 0)]
        let subhrs = subHoursOptions[pickerView.selectedRow(inComponent: 2)]
        return Double("\(hrs).\(subhrs)")!
    }
    
    // Delegates
    var delegate: CashierDelegate?


    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up new cashier
        if cashier == nil {
            isNew = true
            textField.becomeFirstResponder()
        }
        
        // Set up existing cashier
        else {
            isNew = false
            
            // Bring up keyboard if name is empty
            if cashier!.name == "?" {
                textField.text = ""
                textField.becomeFirstResponder()
            }
            else {
                textField.text = cashier!.name
            }
            selectHoursInPickerView(hours: cashier!.hoursWorked)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    // MARK: - Target-Actions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let cashier = Cashier(name: nameEntered, hoursWorked: hoursSelected)
        if cashier.name == "?" && cashier.hoursWorked == 0 {
            showEmptyCashierAlert()
        }
        else {
            dismiss(animated: true, completion: {
                self.delegate?.cashierUpdated(cashier: cashier, isNew: self.isNew, cashierIndex: self.cashierIndex)
            })
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Helper Functions
    private func selectHoursInPickerView(hours: Double) {
        pickerView.selectRow(Int(hours), inComponent: 0, animated: false)
        pickerView.selectRow(Int(hours * 100) % 100, inComponent: 2, animated: false)
    }
    
    private func showEmptyCashierAlert() {
        // create the alert
        let alert = UIAlertController(title: "Empty Cashier", message: "Please enter cashier info or use the cancel button.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - Cashier Delegate
protocol CashierDelegate {
    func cashierUpdated(cashier: Cashier, isNew: Bool, cashierIndex: Int)
}

// MARK: - TextFieldDelegate
extension CashierViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
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



