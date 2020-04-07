//
//  ExpenseRepository.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 03/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit
import CoreData

class ExpenseRepository{
    static func fetchExpenses() -> [Expense]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        
        do {
            let expenses = try managedContext.fetch(fetchRequest)
            return expenses
        } catch let error as NSError {
            print(error)
        }
        
        return []
    }
    
    static func createExpense(date:Date, price:Int64, note:String, period:Period, entertainment:Entertainment) -> Expense?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let expense = Expense(context: managedContext)
        expense.date = date
        expense.price = price
        expense.note = note
        expense.period = period
        expense.entertainment = entertainment
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print(error)
            return nil
        }
        return expense
    }
    
    static func updateExpense(expense:Expense, newNote:String, newPrice:Int64, newDate:Date, newEntertainment:Entertainment){
        let expenses = fetchExpenses()
        if (expenses.filter { $0.date == newDate }.count == 1){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            expense.note = newNote
            expense.price = newPrice
            expense.date = newDate
            expense.entertainment = newEntertainment
            
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print(error)
            }
        }
    }
    
    static func deleteExpense(expense:Expense){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            managedContext.delete(expense)
            try managedContext.save()

        }
        catch let error as NSError {
            print(error)
        }
    }
}
