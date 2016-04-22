//
//  QRcodeVC.swift
//  BarCodeWifi
//
//  Created by mhtran on 4/17/16.
//  Copyright © 2016 mhtran. All rights reserved.
//
//

import UIKit

import Photos
import AssetsLibrary

class QRcodeVC: UIViewController {
    var textField: UITextField?
    var textField2: UITextField?
    var dataToQR: String!
    var image: CGImage!
    let AES = CryptoJS.AES()
    //    VPCameraCustomAlbum.swift -> static let albumName = "YOUR-ALBUM-NAME"
    
    @IBOutlet weak var qrcodeImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    
    override func viewDidLoad() {
        
        image = generateQRCodeFromString(dataToQR)
        qrcodeImage.image = UIImage(CGImage: image)
        
    }
    
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }
    
    func setdata(data: String) {
        dataToQR = data
    }
    
    func configurationTextField(textField: UITextField!)
    {
        if 1 != nil {
            let placeholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
            textField.attributedPlaceholder = placeholder
            
            
        }
    }
    
    func configurationTextField2(textField2: UITextField!)
    {
        if 2 != nil {
            let placeholder = NSAttributedString(string: "Confirm Password", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
            textField2.attributedPlaceholder = placeholder
            
        }
    }
    
    
    @IBAction func encryption(sender: AnyObject) {
        textField?.text = ""
        textField2?.text = ""
        alertViewEncryption()
        
    }
    
    func alertViewEncryption() {
        let alert = UIAlertController(title: "Encryption", message: "Password", preferredStyle:
            UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(configurationTextField2)
        self.textField = alert.textFields![0] as UITextField!
        self.textField2 = alert.textFields![1] as UITextField!
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            print("User click Ok button")
            print(self.textField!.text)
            print(self.textField2!.text)
            self.clickEncryption()
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) in
            
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
            
        })
        
        
    }
    
    func clickEncryption() {
        
         let encrypted = "ENC;" + "ENC:" + AES.encrypt(dataToQR, secretKey: textField!.text!)
         print(AES.decrypt(encrypted, secretKey: textField!.text!))
        qrcodeImage.image = UIImage(CGImage: generateQRCodeFromString(String(encrypted))!)
        
        
    }
    
    func checkTextFieldAlert(textField: UITextField, textField2: UITextField) {
        var alertTest: UIAlertController!
        if (self.textField!.text!.isEmpty) || (self.textField2!.text!.isEmpty) {
            alertTest =  UIAlertController(title: "No Text", message: "Please Enter Text In The Box", preferredStyle:
                UIAlertControllerStyle.Alert)
            alertTest.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
                //                self.alertViewEncryption()
            }))
            self.presentViewController(alertTest, animated: true, completion: nil)
        }
        else if (self.textField!.text! != self.textField2!.text!) {
            alertTest = UIAlertController(title: "Wrong Password", message: "Please Enter Pasword Again", preferredStyle:
                UIAlertControllerStyle.Alert)
            alertTest.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
                //                self.alertViewEncryption()
            }))
            self.presentViewController(alertTest, animated: true, completion: nil)
        }
        else {
            NSLog("OK")
        }
        
    }
    
    func generateQRCodeFromString(string: String) -> CGImage? {
        let data = string.dataUsingEncoding(NSISOLatin1StringEncoding)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            let transform = CGAffineTransformMakeScale(10, 10)
            
            if let output = filter.outputImage?.imageByApplyingTransform(transform) {
                displayQRCodeImage(output)
                let context = CIContext(options:[kCIContextUseSoftwareRenderer : true])
                let trueImage: CGImage = context.createCGImage(output, fromRect: output.extent)
                
                return trueImage
            }
        }
        
        return nil
    }
    
    func displayQRCodeImage(image: CIImage) {
        
    }
    
    func saveImageCGImgae(image: CGImage) {
        let orientation = ALAssetOrientation.Up
        let test = ALAssetsLibrary()
        test.writeImageToSavedPhotosAlbum(image,
                                          orientation: orientation,
                                          completionBlock:{ (path:NSURL!, error:NSError!) -> Void in
                                            print("Path \(path) Error\(error)")
                                            if path != nil {
                                                let alert = UIAlertController(title: "Saved", message: "Your image has been saved to Photo Library!", preferredStyle: UIAlertControllerStyle.Alert)
                                                alert.addAction(UIAlertAction(title:"OK", style: .Default, handler: nil))
                                                self.presentViewController(alert, animated: true, completion: nil)
                                            }
        })
        
    }
    
    @IBAction func saveQRcode(sender: AnyObject) {
        NSLog("Save image")
        saveImageCGImgae(image)
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}
