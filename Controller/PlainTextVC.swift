//
//  PlainTextVC.swift
//  BarCodeWifi
//
//  Created by mhtran on 4/19/16.
//  Copyright © 2016 mhtran. All rights reserved.
//

import UIKit

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
        let star: String = "+"
        var l = 0
        var temp:String = ""
        if (dataQRcodeScan.rangeOfString(" WIFI:S:") != nil) {
            for i in dataQRcodeScan.characters {
                NSLog("a[i]= \(i)")
                
                ssid =  ssid + String(i)
                if star == String(i) && l == 0 {
                    l += 1
                    pass = pass + String(i)
                } else if star == String(i) && l == 1{
                    encrypt = encrypt + String(i)
                }
            }

        }
        
        firstLabelIToShow.text = "Network Name: " + ssid
        secondLabelToShow.text = "Password: " + pass
        thirdLabelToShow.text = "Type: " + encrypt
        

        
    }
    
    func setData(data: String) {
        dataQRcodeScan = data
    }
    
    func printTimestamp() -> String {
         let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
//        print(timestamp)
        return timestamp
    }
    func correct(str:String, orig:String, repl:String) -> String {
        var s = NSMutableString(string:str)
        let r = NSRegularExpression(
            pattern: "\\b\(orig)\\b",
            options: .CaseInsensitive, error: nil)!
        r.replaceMatchesInString(
            s, options: nil, range: NSMakeRange(0,s.length),
            withTemplate: repl)
        return s as String
    }

    
    
    @IBAction func showQRCode(sender: AnyObject) {
    }
    

}
