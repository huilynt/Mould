//
//  BarcodeViewController.swift
//  Grocery List
//
//  Created by MAD2 on 25/1/19.
//  Copyright © 2019 Weijie. All rights reserved.
//

import UIKit
import MTBBarcodeScanner

class BarcodeViewController: UIViewController {

    @IBOutlet weak var scannerView: UIView!
    var scanner: MTBBarcodeScanner?
    var scanning: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner = MTBBarcodeScanner(previewView: scannerView)
    }
    
    @IBAction func btnScan(_ sender: Any) {
        scanning = !scanning;
        if !scanning {
            scanner?.stopScanning()
        } else {
            MTBBarcodeScanner.requestCameraPermission(success: { success in
                if success {
                    do {
                        try self.scanner?.startScanning(resultBlock: { codes in
                            if let codes = codes {
                                for code in codes {
                                    let stringValue = code.stringValue!
                                    print("Found code: \(stringValue)")
                                    self.scanner?.stopScanning()
                                    self.scanning = false
                                    
                                    let alertController = UIAlertController(title: "Found the code!", message: "\(code.stringValue!)", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alertController.addAction(okAction)
                                    self.present(alertController, animated: true)
                                }
                            }
                        })
                    } catch {
                        NSLog("Unable to start scanning")
                    }
                } else {
                    let alertController = UIAlertController(title: "Camera access denied!", message: "Please allow access to camera to use the scanner!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                }
            })
        }
    }
    
}

