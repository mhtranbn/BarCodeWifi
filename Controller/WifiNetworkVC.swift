//
//  WifiNetworkVC.swift
//  BarCodeWifi
//
//  Created by mhtran on 4/17/16.
//  Copyright © 2016 mhtran. All rights reserved.
//

import UIKit

class WifiNetworkVC: UIViewController {
    @IBOutlet var createQRButton: UIView!

    @IBOutlet weak var ssidWifi: UITextField!
    @IBOutlet weak var passwordWifiTextField: UITextField!
    
    @IBOutlet weak var networkEncyptionType: UISegmentedControl!
    
    var data: String = ""
    var networkType: String = "WPA2/WPA"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        createQRButton.hidden = true
        
        let a = ["?","\"","$","\\","]","+"]
        var bool: Bool = false
        for i in 0...5 {
            if passwordWifiTextField == a[i] {
                print("wrong pass")
                bool = true
            }
            
        }
        
        if ssidWifi == "" || bool == true {
            print("wrong ssid")
            
        } else {
            createQRButton.hidden = false
        }
        
    }
    
    @IBAction func setValueTypeNetwork(sender: AnyObject) {
        
        switch networkEncyptionType.selectedSegmentIndex {
        case 0: networkType = "WPA2/WPA"
        case 1: networkType = "WPE"
        case 2: networkType = "None"
        default :
            break
        }
    }
    
    
    
    
    @IBAction func createQRcodeAction(sender: AnyObject) {
        //  ?, ", $, [, \, ], and +.
        let a = ["?","\"","$","\\","]","+"]
        var bool: Bool = false
        for i in 0...5 {
            if passwordWifiTextField == a[i] {
                print("wrong pass")
                bool = true
            }
            
        }
        
        if ssidWifi == "" || bool == true {
            print("wrong ssid")
            
        } else {
            data = ssidWifi.text! + "+" + passwordWifiTextField.text! + "+" + networkType
            createQRButton.hidden = false
            navigationController?.pushViewController(({
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier("qrcodeVC") as! QRcodeVC
                vc.setdata(data)
               return vc })(), animated: true)
        }

    }
 
}
