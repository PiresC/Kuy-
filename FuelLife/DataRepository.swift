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
    static func createPeriod(month:Date, currentBudget:Int64, startingBudget:Int64){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
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
        }
    }

    static func fetchPeriods() -> [Period]?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Period>(entityName: "Period")
        
        do {
            let periods = try managedContext.fetch(fetchRequest)
            return periods
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    static func updatePeriod(period:Period){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Period>(entityName: "Period")
        fetchRequest.predicate = NSPredicate(format: "month = %@", period.month as! NSDate)
    }
}
