//
//  PantryItemDetailsViewController.swift
//  InventoryApp
//
//  Created by MAD2 on 25/1/19.
//  Copyright © 2019 groceryapp. All rights reserved.
//

import UIKit

class PantryItemDetailsViewController: UIViewController {
    
    var name: String = ""
    var quantity: Int32 = 0
    var price: Double = 0.0
    
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = name
    }
}
