//
//  AddInventoryViewController.swift
//  GroceryApp
//
//  Created by MAD2 on 9/1/19.
//  Copyright © 2019 groceryapp. All rights reserved.
//

import UIKit
import Photos
class AddPantryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let datePicker = UIDatePicker()
    var expiryDate: [Date] = []
    var dateObserver: NSObjectProtocol?
    var imageObserver: NSObjectProtocol?
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    var image: UIImage = UIImage()
    var pantryItem = PantryItem()
    
    var indexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddPantryViewController.handleSelectImageView))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dateObserver = NotificationCenter.default.addObserver(forName: .saveDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVc = notification.object as! DatePopupViewController
            self.expiryDate.append(dateVc.date)
            self.tableView.reloadData()
        }
        
        imageObserver = NotificationCenter.default.addObserver(forName: .saveImage, object: nil, queue: OperationQueue.main, using: { (notification) in
            let imageVc = notification.object as! AddImageViewController
            self.imageView.image = imageVc.image
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let dateObserver = dateObserver {
            NotificationCenter.default.removeObserver(dateObserver)
        }
        if let imageObserver = imageObserver {
            NotificationCenter.default.removeObserver(imageObserver)
        }
    }
    
    @objc func handleSelectImageView() {
//        let storyboard = UIStoryboard(name: "AddImage", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController()!
//        self.present(vc, animated: true)
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        let alert = UIAlertController(title: "Where's your photo?", message: "Choose a source", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                myPickerController.sourceType = .camera
                self.present(myPickerController, animated: true)
            } else {
                print("no camera")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                myPickerController.sourceType = .photoLibrary
                self.present(myPickerController, animated: true)
            } else {
                print("no camera")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        PantryItemFunctions.createItem(image: image,
                                       name: txtName.text!,
                                       quantity: Int32(txtQuantity.text!)!,
                                       price: Double(txtPrice.text!)!,
                                       expiryDate: expiryDate)
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func CreateItem() {
        let context = appDelegate.persistentContainer.viewContext
        
        let pantryItem = PantryItem(context: context)
        // store image
        pantryItem.name = txtName.text
        pantryItem.quantity = Int32(txtQuantity.text!)!
        pantryItem.price = Double(txtPrice.text!)!
        
        for date:Date in expiryDate {
            let expiry = ExpiryDate(context: context)
            expiry.date = date
            print(expiry)
            pantryItem.addToExpiry(expiry)
        }
        
        appDelegate.saveContext()
        print(pantryItem)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expiryDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath)
        let row = indexPath.row
        
        let date = expiryDate[row]
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        cell.textLabel?.text = formatter.string(from: date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            let storyboard = UIStoryboard(name: "DatePopup", bundle: nil)
            let popup = storyboard.instantiateInitialViewController()!
            self.present(popup, animated: true)
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            // Perform delete
            self.expiryDate.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }

}

extension AddPantryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            print(image.size)
            self.image = image
            imageView.image = image
        } else {
            print("cannot pick image")
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
