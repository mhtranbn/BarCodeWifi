//
//  PlainTextVC.swift
//  BarCodeWifi
//
//  Created by mhtran on 4/19/16.
//  Copyright © 2016 mhtran. All rights reserved.
//

import UIKit
import SwiftString

class PlainTextVC: UIViewController {

    @IBOutlet weak var firstLabelIToShow: UILabel!
    
    @IBOutlet weak var secondLabelToShow: UILabel!
    
    @IBOutlet weak var thirdLabelToShow: UILabel!
    
    @IBOutlet weak var timeSaveQRCode: MaterialButton!
    
    @IBOutlet weak var timeSaveQRcodeLabel: UILabel!
    
    var dataQRcodeScan: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeSaveQRcodeLabel.text = printTimestamp()
        var arrayString: Array = [String]()
//        let a = Array(dataQRcodeScan)
        var ssid:String = ""
        var pass:String = ""
        var encrypt:String = ""
        var temp:String = ""
        
        if (dataQRcodeScan.rangeOfString("WIFI:S:") != nil) {
            dataQRcodeScan = dataQRcodeScan.chompLeft("WIFI:S:")
            NSLog("dataQRcode = \(dataQRcodeScan)")
            ssid = getStringFromStringByCharacter(dataQRcodeScan, character: ";")
            NSLog("ssid = \(ssid)")
            dataQRcodeScan = dataQRcodeScan.chompLeft(ssid + ";T:")
            NSLog("dataQRcode = \(dataQRcodeScan)")
            encrypt = getStringFromStringByCharacter(dataQRcodeScan, character: ";")
            NSLog("encrypt = \(encrypt)")
            NSLog("ssid = \(ssid)")
            dataQRcodeScan = dataQRcodeScan.chompLeft(encrypt + ";P:")
            NSLog("dataQRcode = \(dataQRcodeScan)")
            pass = dataQRcodeScan.chompRight(";;")
            NSLog("encrypt +  = \(encrypt + ";P:")")
            firstLabelIToShow.text = "Network Name: " + ssid
            secondLabelToShow.text = "Password: " + pass
            thirdLabelToShow.text = "Type: " + encrypt
        } else {
            firstLabelIToShow.text = dataQRcodeScan
            secondLabelToShow.text = ""
            thirdLabelToShow.text = ""
        }
    }
    
    func getStringFromStringByCharacter(totalString: String, character: String) -> String {
        var result:String = ""
        let k:Bool = false
        
        for i in 0...totalString.characters.count {
            NSLog("String(totalString[i]) = \(String(totalString[i]))")
            NSLog("i ====== \(i)")
            let a = totalString.substringWithRange(0, location: i)
            NSLog("a = \(a)")
            if String(totalString[i]) == character && k == false {
                k == true
                result = totalString.substringWithRange(0, location: i)
                NSLog("result = \(result)")
                break

            }
            
            
        }
        
        return result
//
    }
    
    func setData(data: String) {
        dataQRcodeScan = data
    }
    
    func printTimestamp() -> String {
         let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
//        print(timestamp)
        return timestamp
    }
    
    
    
    @IBAction func showQRCode(sender: AnyObject) {
    }
    

}
