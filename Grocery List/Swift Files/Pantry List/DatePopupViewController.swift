//
//  DatePopupViewController.swift
//  GroceryApp
//
//  Created by MAD2 on 16/1/19.
//  Copyright © 2019 groceryapp. All rights reserved.
//

import UIKit

class DatePopupViewController: UIViewController {

    
    @IBOutlet weak var datePicker: UIDatePicker!
    var setDate:Date = Date()
    var date: Date {
        get {
            return datePicker.date
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        NotificationCenter.default.post(name: .saveDate, object: self)
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.minimumDate = Date()
        datePicker.setDate(date, animated: true)
    }

}
