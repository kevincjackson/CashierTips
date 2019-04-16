//
//  ViewController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/4/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var worldState: WorldState!
    var sections = ["Total Tips", "Cashiers"]
    
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
            totalTipsVC.selectedAmount = worldState.totalTips
        }
        else if segue.identifier == "newCashier" {
            let cashierVC = segue.destination as! CashierViewController
            cashierVC.delegate = self
        }
        else if segue.identifier == "editCashier"{
            let cashierVC = segue.destination as! CashierViewController
            cashierVC.delegate = self
            cashierVC.cashier = worldState.cashiers[tableView.indexPathForSelectedRow!.row]
            cashierVC.cashierIndex = tableView.indexPathForSelectedRow!.row
        }
        else {
            print("Unknown segue identifier")
        }
    }
    
    // MARK: - Target-Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newCashier", sender: self)
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if isEditing {
            setEditing(false, animated: true)
            editButton.title = "Edit"
        }
        else {
            setEditing(true, animated: true)
            editButton.title = "Done"
        }
    }
    
    // MARK: - Helper Functions
    @objc fileprivate func animateTableViewReloadData() {
        UIView.transition(with: tableView,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }
    
    // MARK: - TableView Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : worldState.cashiers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell: UITableViewCell

        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "totalTipsCell", for: indexPath)
            cell.textLabel?.text = String(format: "$%.2f", worldState.totalTips)
            cell.detailTextLabel?.text = worldState.totalTipsDescription
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cashierCell", for: indexPath)
            let cashier = worldState.cashiers[indexPath.row]
            cell.textLabel?.text = cashier.name + String(format: " (%.2f h)", cashier.hoursWorked)
            cell.detailTextLabel?.text = cashier.getTipsDescribed(rate: worldState.tipRate)
        }

        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if indexPath.section == 0 {
                worldState.totalTips = 0.0
                animateTableViewReloadData()
            }
            else {
                worldState.removeCashier(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                // Add delay to allow for the row deletion
                perform(#selector(animateTableViewReloadData),
                        with: nil,
                        afterDelay: 0.4
                )
            }
        }
        
    }
    
    // MARK: Moving Rows
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
        
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        worldState.moveCashier(
            from: sourceIndexPath.row,
            to: destinationIndexPath.row
        )
    }
    
    // MARK: Headers
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        // Header text
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: Constants.HeaderFontSize)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.HeaderFontSize + Constants.Padding
    }
    
    // MARK: Footers
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        else {
            if worldState.cashiers.isEmpty {
                let footerView = UITableViewHeaderFooterView()
                footerView.backgroundView = UIView(frame: footerView.bounds)
                footerView.backgroundView?.backgroundColor = UIColor.white
                footerView.textLabel?.text = "Tap '+' to add cashiers."

                return footerView
            }
            else {
                
                return nil
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
            let footerView = view as! UITableViewHeaderFooterView
            footerView.textLabel?.textColor = UIColor.lightGray
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else {
            if worldState.cashiers.isEmpty {
                return 60
            }
            else {
                return 0
            }
        }
    }
 
    
    // MARK: - TableView Delegate
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
        worldState.totalTips = amount
        
        // Update view
        animateTableViewReloadData()
    }
}


// MARK: - CashierDelegate
extension MainViewController: CashierDelegate {
    
    func cashierUpdated(cashier: Cashier, isNew: Bool, cashierIndex: Int) {
        
        // Add new cashier
        if isNew {
            worldState.addCashier(cashier: cashier)
            let indexPath = IndexPath(row: (worldState.cashiers.count - 1), section: 1)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        // Replace existing cashier
        else {
            worldState.cashiers[cashierIndex] = cashier
        }
        
        animateTableViewReloadData()
    }
    
}

