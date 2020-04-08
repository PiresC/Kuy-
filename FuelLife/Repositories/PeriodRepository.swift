//
//  DataRepository.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 03/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit
import CoreData

class PeriodRepository{
    static func getCurrentPeriod() -> Period?{
        let data = fetchPeriods()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YYYY"
        let month = dateFormatter.string(from: now)
        
        if let period = (data.filter { $0.month == month }.first){
            return period
        }
        return createPeriod(month: month, currentBudget: 0, startingBudget: 0)
    }
    
    static func resetBudget(){
        let data = fetchPeriods()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YYYY"
        let month = dateFormatter.string(from: now)
        
        if let period = (data.filter { $0.month == month }.first){
            updatePeriod(period: period, startingBudget: period.startingBudget, currentBudget: period.startingBudget)
        }
    }
    
    static func editBudget(newBudget:Int64){
        let data = fetchPeriods()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YYYY"
        let month = dateFormatter.string(from: now)
        
        if let period = (data.filter { $0.month == month }.first){
            updatePeriod(period: period, startingBudget: period.startingBudget, currentBudget: newBudget)
        }
    }
    
    static func useBudget(amount:Int64){
        let data = fetchPeriods()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YYYY"
        let month = dateFormatter.string(from: now)
        
        if let period = (data.filter { $0.month == month }.first){
            updatePeriod(period: period, startingBudget: period.startingBudget, currentBudget: period.currentBudget-amount)
        }
    }
    
    static func createPeriod(month:String, currentBudget:Int64, startingBudget:Int64)->Period?{
        let periods = fetchPeriods()
        if (periods.filter { $0.month == month }.count == 0){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return nil
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let period = Period(context: managedContext)
            period.month = month
            period.currentBudget = currentBudget
            period.startingBudget = startingBudget
            
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print(error)
                return nil
            }
            return period
        }
        return periods.filter { $0.month == month }.first
    }

    static func fetchPeriods() -> [Period]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Period>(entityName: "Period")
        let sort = NSSortDescriptor(key: #keyPath(Period.month), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let periods = try managedContext.fetch(fetchRequest)
            return periods
        } catch let error as NSError {
            print(error)
        }
        
        return []
    }
    
    static func updatePeriod(period:Period, startingBudget:Int64, currentBudget:Int64){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Period>(entityName: "Period")
        fetchRequest.predicate = NSPredicate(format: "month = %@", period.month!)
        
        period.currentBudget = currentBudget
        period.startingBudget = startingBudget
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    static func deletePeriod(period:Period){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            managedContext.delete(period)
            try managedContext.save()

        }
        catch let error as NSError {
            print(error)
        }
    }
}
