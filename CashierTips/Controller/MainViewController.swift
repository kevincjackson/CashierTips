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
    var totalTips: Double = 0.0 { didSet { tableView.reloadData() } }
    var cashiers = [Cashier]()  { didSet { tableView.reloadData() } }
    var sections = ["Total Tips", "Cashiers"]

    // Computed Properties
    var tipRate: Double {
        return totalHoursWorked != 0 ? totalTips / totalHoursWorked : 0
    }
    var totalHoursWorked: Double {
        return cashiers.reduce(0) { $0 + $1.hoursWorked }
    }
    var totalTipsDescription: String {
        return "Total Hours: \(totalHoursWorked), Tip Rate: \(tipRate)"
    }
    
    
//    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set nav title
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
        totalTips = amount
    }
}


// MARK: - CashierDelegate
extension MainViewController: CashierDelegate {
    func cashierUpdated(cashier: Cashier, isNew: Bool) {
        if isNew {
           cashiers.append(cashier)
        }
        else {
            // TODO
            print("TODO NOT A NEW CASHIER")
        }
    }
    

}

