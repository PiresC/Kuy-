//
//  EntertainmentRepository.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 03/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit
import CoreData

class EntertainmentRepository{
    static func getEntertainmentReport() -> [BudgetDetail]{
        let period = PeriodRepository.getCurrentPeriod()
        var result:[BudgetDetail] = []
        for i in fetchEntertainments(){
            if var temp = i.expenses?.array as? [Expense]{
                temp = temp.filter { (e) -> Bool in
                    return e.period == period
                }
                var totalUsed = 0
                for x in temp{
                    totalUsed += Int(x.price)
                }
                let percentage = Int(Double(totalUsed) / Double(Int(period!.startingBudget)) * 100)
                result.append(BudgetDetail(name: i.name!, backgroundColor: i.color!, percentage: percentage, expenses: temp))
            }
        }
        return result
    }
    
    static func fetchEntertainments() -> [Entertainment]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Entertainment>(entityName: "Entertainment")
        
        do {
            let entertainments = try managedContext.fetch(fetchRequest)
            return entertainments
        } catch let error as NSError {
            print(error)
        }
        
        return []
    }
    
    static func createEntertainment(name:String, basePrice:Int64,color:String) -> Entertainment?{
        let entertainments = fetchEntertainments()
        if (entertainments.filter { $0.name == name }.count == 0){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return nil
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entertainment = Entertainment(context: managedContext)
            entertainment.name = name
            entertainment.basePrice = basePrice
            entertainment.color = color
            
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print(error)
                return nil
            }
            return entertainment
        }
        return entertainments.filter { $0.name == name }.first
    }
    
    static func updateEntertainment(entertainment:Entertainment, newName:String, newBasePrice:Int64, newColor:String){
        let entertainments = fetchEntertainments()
        if (entertainments.filter { $0.name == entertainment.name }.count == 1){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            entertainment.name = newName
            entertainment.basePrice = newBasePrice
            entertainment.color = newColor
            
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print(error)
            }
        }
    }
    
    static func deleteEntertainment(entertainment:Entertainment){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            managedContext.delete(entertainment)
            try managedContext.save()

        }
        catch let error as NSError {
            print(error)
        }
    }
    
    static func fetchRecommendationEntertainments() -> [Entertainment]{
        
        //TODO: Implement Logic for recommmedation base on user data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Entertainment>(entityName: "Entertainment")

        do {
            let entertainments = try managedContext.fetch(fetchRequest)
            return entertainments
        } catch let error as NSError {
            print(error)
        }
        
        return []
        
    }
    
}
