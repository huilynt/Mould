//
//  InventoryTableViewController.swift
//  GroceryApp
//
//  Created by MAD2 on 9/1/19.
//  Copyright © 2019 groceryapp. All rights reserved.
//

import UIKit

class PantryTableViewController: UITableViewController {

    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    
    var indexSelected: Int?
    
    @IBAction func btnAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddPantry", bundle: nil)
        let addPantry = storyboard.instantiateInitialViewController()!
        self.present(addPantry, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PantryItemFunctions.readItems()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        PantryItemFunctions.readItems()
        tableView.reloadData()
    }
//
//    func readData() {
//        let context = appDelegate.persistentContainer.viewContext
//        do {
//            let result = try context.fetch(PantryItem.fetchRequest())
//            Data.itemModels = result as! [PantryItem]
//            tableView.reloadData()
//        } catch {
//            print("Stupid Assignment")
//        }
//    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.itemModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)

        let name = Data.itemModels[indexPath.row].name
        let quantity = String(Data.itemModels[indexPath.row].quantity)
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = quantity

        return cell
    }
  
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
            self.indexSelected = indexPath.row
            
            let storyboard = UIStoryboard(name: "AddPantry", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()!
            self.present(vc, animated: true)
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            let alert = UIAlertController(title: "Delete all quantities?", message: "Edit instead?", preferredStyle: .alert)
            
            let delete = UIAlertAction(title: "Delete", style: .default, handler: { (alert) in
                Data.itemModels.remove(at: indexPath.row)
            })
            
            let edit = UIAlertAction(title: "Edit", style: .default, handler: { (alert) in
                self.indexSelected = indexPath.row
                
                let storyboard = UIStoryboard(name: "AddPantry", bundle: nil)
                let vc = storyboard.instantiateInitialViewController()!
                self.present(vc, animated: true)
            })
            alert.addAction(delete)
            alert.addAction(edit)
            
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }

   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ToPantryItemDetailsSegue" {
            indexSelected = tableView.indexPathForSelectedRow?.row
            let pantryItem = Data.itemModels[indexSelected!]
            
            let pantryItemDetailsViewController = segue.destination as! PantryItemDetailsViewController
            pantryItemDetailsViewController.name = pantryItem.name!
            pantryItemDetailsViewController.quantity = pantryItem.quantity
            pantryItemDetailsViewController.price = pantryItem.price
//            pantryItemDetailsViewController.expiryDate = pantryItem.expiryDate
            
        
            let context = appDelegate.persistentContainer.viewContext
            do {
                let result = try context.fetch(PantryItem.fetchRequest())
                let allPantryItems = result as! [PantryItem]
                
                for pantryItem in allPantryItems {
                    print(pantryItem.name!)
                    let allDates = pantryItem.expiry?.allObjects as! [ExpiryDate]
                    for date in allDates {
                        print(date.date)
                    }
                }
            } catch {
                print("Stupid assignment")
            }
            
            
            
            
        }
    }
    

}
