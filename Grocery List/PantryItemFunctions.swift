//
//  InventoryItemFunctions.swift
//  InventoryApp
//
//  Created by Mad2 on 23/1/19.
//  Copyright © 2019 groceryapp. All rights reserved.
//

import UIKit

let appDelegate = (UIApplication.shared.delegate) as! AppDelegate

class PantryItemFunctions {
    
    
    static func createItem(image: UIImage, name: String, quantity: Int32, price: Double, expiryDate: [Date]) {
        let context = appDelegate.persistentContainer.viewContext
        
        let pantryItem = PantryItem(context: context)
        pantryItem.name = name
        pantryItem.quantity = quantity
        pantryItem.price = price
        
        for date:Date in expiryDate {
            let expiry = ExpiryDate(context: context)
            expiry.date = date
            print(expiry)
            pantryItem.addToExpiry(expiry)
        }
        
        appDelegate.saveContext()
        print(pantryItem)
    }
    
    static func readItems() {
        let context = appDelegate.persistentContainer.viewContext
        do {
            let result = try context.fetch(PantryItem.fetchRequest())
            Data.itemModels = result as! [PantryItem]
            
//            for pantryItem in allPantryItems {
//                print(pantryItem.name!)
//                let allDates = pantryItem.expiry?.allObjects as! [ExpiryDate]
//                for date in allDates {
//                    print(date.date)
//                }
//            }
        } catch {
            print("Stupid assignment")
        }
    }
    
    static func updateItem(pantryItem: PantryItem) {
        
    }
    
    static func deleteItem(pantryItem: PantryItem) {
        
    }
}
