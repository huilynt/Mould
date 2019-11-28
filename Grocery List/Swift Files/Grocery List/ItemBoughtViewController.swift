//
//  ItemBoughtViewController.swift
//  Grocery List
//
//  Created by MAD2 on 23/1/19.
//  Copyright © 2019 Weijie. All rights reserved.
//

import UIKit
import AVFoundation

class ItemBoughtViewController: UIViewController {
    
    var previousVC = GroceryItemTableViewController()
    var selectedGroceryItem : GroceryItemCD?
    var audioPlayer = AVAudioPlayer()
    let cartSound = URL(fileURLWithPath: Bundle.main.path(forResource: "cart", ofType: "mp3")!)
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = selectedGroceryItem?.name
    }
    
    //Complete Button
    @IBAction func completeBtn(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {            
            if let theGroceryItem = selectedGroceryItem {
                context.delete(theGroceryItem)
                navigationController?.popViewController(animated: true)
            }
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: cartSound)
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        
    }
}
