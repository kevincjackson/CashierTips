//
//  ViewController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/4/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class TipTrackingSheetController: UITableViewController {

    // Stored properties
    var totalTips: Double = 0.0 { didSet { tableView.reloadData() } }
    var cashiers = [Cashier]()
    var sections = ["Total Tips", "Cashiers"]

    
    // Computed Properties
    var tipRate: Double {
        return totalHoursWorked != 0 ? totalTips / totalHoursWorked : 0
    }
    var totalHoursWorked: Double {
        return cashiers.reduce(0) { $0 + $1.hoursWorked }
        
    }
    var totalTipsDescription: String = "TODO"

//        if let totalHoursWorked = totalHoursWorked {
//            return "Total Hours: \(totalHoursWorked), Tip Rate: \(tipRate!)"
//        }
//        else {
//            return "Total Hours: 0, Tip Rate: 0"
//        }

//    {
////        didSet {
////            cashiers.forEach { $0.tipRate = self.tipRate! }
////            tableView.reloadData()
////        }
//    }

//    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set nav title
        title = "Cashier Tips"
        
        cashiers = [
            Cashier(name: "Kevin", hoursWorked: 1.5),
            Cashier(name: "Jessica", hoursWorked: 4.5),
            Cashier(name: "Calvin", hoursWorked: 7.2),
        ]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoTotalTips" {
            let totalTipsVC = segue.destination as! DollarAmountViewController
            totalTipsVC.delegate = self
            totalTipsVC.selectedAmount = totalTips
        }
        else {
            let cashierVC = segue.destination as! CashierViewController
            cashierVC.delegate = self
//            let cashier = cashiers[tableView.indexPathForSelectedRow!.row]
//            print(cashier.name)
        }
    }

    // MARK: - Tableview
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
            cell.textLabel?.text = "$\(totalTips)"
            cell.detailTextLabel?.text = totalTipsDescription
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cashierCell", for: indexPath)
            let cashier = cashiers[indexPath.row]
            cell.textLabel?.text = "\(cashier.name) (\(cashier.hoursWorked) h)"
//            cell.detailTextLabel?.text = "$\(cashier.tipAmountDescription ?? String(0))"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        // Header text
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 36)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36 + 2 * 8
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            performSegue(withIdentifier: "gotoTotalTips", sender: self)
        }
        else {
            performSegue(withIdentifier: "gotoCashier", sender: self)
        }
    }
}


// MARK: - DollarAmountViewDelegate
extension TipTrackingSheetController: DollarAmountViewDelegate {
    func dollarAmountUpdated(amount: Double) {
        totalTips = amount
    }
}


// MARK: - CashierDelegate
extension TipTrackingSheetController: CashierDelegate {
    func cashierUpdated(name: String, hoursWorked: Double) {
        if let row = self.tableView.indexPathForSelectedRow?.row {
            print(String(row))
        }
        else {
            print("No row selected")
        }
    }
}

