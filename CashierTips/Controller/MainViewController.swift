//
//  ViewController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/4/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

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
    
    
//    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize navigation
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Cashier Tips"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoTipView" {
            let totalTipsVC = segue.destination as! TipViewController
            totalTipsVC.delegate = self
            totalTipsVC.selectedAmount = totalTips
        }
        else if segue.identifier == "newCashier" {
            let cashierVC = segue.destination as! CashierViewController
            cashierVC.delegate = self
        }
        else if segue.identifier == "editCashier"{
            let cashierVC = segue.destination as! CashierViewController
            cashierVC.delegate = self
            cashierVC.cashier = cashiers[tableView.indexPathForSelectedRow!.row]
        }
        else {
            print("Unknown segue identifier")
        }
    }
    
    // MARK: - Target-Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newCashier", sender: self)
    }

    // MARK: - Helper Functions

    // MARK: - TableView Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : cashiers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell: UITableViewCell

        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "totalTipsCell", for: indexPath)
            cell.textLabel?.text = String(format: "$%.2f", totalTips)
            cell.detailTextLabel?.text = totalTipsDescription
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cashierCell", for: indexPath)
            let cashier = cashiers[indexPath.row]
            cell.textLabel?.text = cashier.name + String(format: " (%.2f h)", cashier.hoursWorked)
            cell.detailTextLabel?.text = cashier.getTipsDescribed(rate: tipRate)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        // Header text
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: Constants.HeaderFontSize)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.HeaderFontSize + Constants.Padding
    }


    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if indexPath.section == 0 {
                totalTips = 0.0
                tableView.reloadData()
            }
            else {
                cashiers.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            }

        }
    }
    
    // MARK: - TableView Datasource
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            performSegue(withIdentifier: "gotoTipView", sender: self)
        }
        else {
            performSegue(withIdentifier: "editCashier", sender: self)
        }
    }
}



// MARK: - DollarAmountViewDelegate
extension MainViewController: TipViewDelegate {
    func tipAmountUpdated(amount: Double) {
        
        // Update model
        totalTips = amount
        
        // Update view
        tableView.reloadData()
    }
}


// MARK: - CashierDelegate
extension MainViewController: CashierDelegate {
    func cashierUpdated(cashier: Cashier, isNew: Bool) {
        
        // Add new cashier
        if isNew {
            cashiers.append(cashier)
        }
        // Replace existing cashier
        else {
            cashiers[tableView.indexPathForSelectedRow!.row] = cashier
        }
        
        // Update view
        tableView.reloadData()
    }
    
}

