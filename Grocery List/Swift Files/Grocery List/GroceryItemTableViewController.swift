//
//  GroceryItemTableViewController.swift
//  Grocery List
//
//  Created by MAD2 on 23/1/19.
//  Copyright © 2019 Weijie. All rights reserved.
//

import UIKit

class GroceryItemTableViewController: UITableViewController {

    var groceryItems : [GroceryItemCD] = []
    var selectedGroceryItem : GroceryItemCD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Updates the view as soon as the user adds an item
    override func viewWillAppear(_ animated: Bool) {
        getGroceryItems()
    }
    
    //Get the grocery items from Core Data
    func getGroceryItems() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataGroceryItems = try? context.fetch(GroceryItemCD.fetchRequest()) as? [GroceryItemCD] {
                if let theGroceryItems = coreDataGroceryItems {
                    groceryItems = theGroceryItems
                    tableView.reloadData()
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems.count
    }

    //Updates the data on every cell of the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryTableCell", for: indexPath)

        let groceryItem = groceryItems[indexPath.row]
        
        if let name = groceryItem.name {
            if groceryItem.important {
                cell.textLabel?.text = "❗️" + name
                cell.detailTextLabel?.text = "Quantity: " + groceryItem.quantity!
            } else {
                cell.textLabel?.text = groceryItem.name
                cell.detailTextLabel?.text = "Quantity: " + groceryItem.quantity!
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: (Bool)-> ()) in
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                if let theGroceryItem = self.selectedGroceryItem {
                    context.delete(self.groceryItems[indexPath.row])
                }
            }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groceryItem = groceryItems[indexPath.row]
        performSegue(withIdentifier: "moveToItemBought", sender: groceryItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddGroceryItemViewController {
            addVC.previousVC = self
        }
        
        if let completeVC = segue.destination as? ItemBoughtViewController {
            
            if let groceryItem = sender as? GroceryItemCD {
                completeVC.selectedGroceryItem = groceryItem
                completeVC.previousVC = self
            }
        }
    }

}
