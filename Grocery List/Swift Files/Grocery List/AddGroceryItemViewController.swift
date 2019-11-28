//
//  AddGroceryItemViewController.swift
//  Grocery List
//
//  Created by MAD2 on 23/1/19.
//  Copyright © 2019 Weijie. All rights reserved.
//

import UIKit
import Speech

class AddGroceryItemViewController: UIViewController, SFSpeechRecognizerDelegate, UITextFieldDelegate {
    
    //Table View
    var previousVC = GroceryItemTableViewController()
    
    //Speech
    var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: Language.instance.setlanguage()))!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addBtn(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let groceryItem = GroceryItemCD(entity: GroceryItemCD.entity(), insertInto: context)
            
            if let titleText = titleTextField.text {
                            groceryItem.name = titleText
                            groceryItem.quantity = quantityTextField.text!
                            groceryItem.important = importantSwitch.isOn
            }
            
            try? context.save()
            navigationController?.popViewController(animated: true)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        speechRecognizer.delegate = self
        requestAuthorization()
        
        
    }
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        if  audioEngine.isRunning {
            
            recognitionRequest?.shouldReportPartialResults = false
            audioEngine.inputNode.removeTap(onBus: 0)
            audioEngine.stop()
            recognitionRequest?.endAudio()
            
            
            recordButton.isEnabled = true
            recordButton.setTitle("Start Recording", for: [])
            
        } else {
            
            try! startRecording()
            
            recordButton.setTitle("Pause recording", for: [])
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleTextField = textField
    }
}
