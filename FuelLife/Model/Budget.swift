//
//  Budget.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/12/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import Foundation

class Budget {
    
    var startingBudget: Int64
    var currentBudget: Int64
    
    
    init(startingBudget: Int64, currentBudget: Int64) {
        self.startingBudget = startingBudget
        self.currentBudget = currentBudget
    }
    
    static func getCurrentBudgetDetails() -> [BudgetDetail] {
        var budgetDetails: [BudgetDetail] = []
        var entertainments: [Entertainment] = []

        entertainments = EntertainmentRepository.fetchEntertainments()
        
        let expenses = ExpenseRepository.fetchExpenses()

        for entertainment in entertainments {
            let budgetdetail = BudgetDetail(name: entertainment.name!, backgroundColor: entertainment.color!, percentage: 30, expenses: expenses)
            budgetDetails.append(budgetdetail)
        }
        
        return budgetDetails
    }
}
