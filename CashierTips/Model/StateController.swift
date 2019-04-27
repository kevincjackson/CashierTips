//
//  StateController.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/26/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class StateController {

    private let storageController: StorageController
    public private(set) var worldState: WorldState

    // MARK: - Save & Init
    init(storageController: StorageController) {
        self.storageController = storageController
        self.worldState = storageController.load() ?? WorldState()
    }

    public func save() {
        storageController.save(worldState: worldState)
    }

    // MARK: - Mutators
    public func addCashier(cashier: Cashier) {
        worldState.cashiers.append(cashier)
    }

    public func updateCashier(cashier: Cashier, at index: Int) {
        worldState.cashiers[index] = cashier
    }

    public func moveCashier(from a: Int, to b: Int) {
        let cashier = worldState.cashiers[a]
        worldState.cashiers.remove(at: a)
        worldState.cashiers.insert(cashier, at: b)
    }

    public func removeCashier(at index: Int) {
        worldState.cashiers.remove(at: index)
    }

    public func setTotalTips(_ amount: Double) {
        worldState.totalTips = amount
    }
}
