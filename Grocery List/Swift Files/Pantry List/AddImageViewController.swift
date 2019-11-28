//
//  AddImage.swift
//  InventoryApp
//
//  Created by MAD2 on 23/1/19.
//  Copyright © 2019 groceryapp. All rights reserved.
//

import UIKit
import Photos

class AddImageViewController: UIViewController {
    
    var image: UIImage = UIImage()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnCamera(_ sender: Any) {
    }
    
    @IBAction func btnGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.imagePicker = UIImagePickerController()
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true)
                    self.dismiss(animated: true)
                default:
                    break
                }
            }
        }
    }
    
}

@objc extension AddImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            NotificationCenter.default.post(name: .saveImage, object: self)
            self.image = image
            print("ye")
        } else {
            print("jio")
        }
        dismiss(animated: true)
    }
}
