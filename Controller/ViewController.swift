//
//  ViewController.swift
//  BarCodeWifi
//
//  Created by mhtran on 4/16/16.
//  Copyright © 2016 mhtran. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    
    @IBOutlet weak var flashButton: MaterialButton!
    
    @IBOutlet weak var switchCameraButton: MaterialButton!
    
    @IBOutlet weak var helpButton: MaterialButton!
    var ResultAndAction: MaterialButton!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrcodeframeView: UIView?
    var result : String!
    var k: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ScanPicture()
        self.view.addSubview(flashButton)
        self.view.addSubview(switchCameraButton)
        self.view.addSubview(helpButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func ScanPicture() {
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error: NSError?
        let input: AnyObject!
        do {
            input = try AVCaptureDeviceInput(device: captureDevice)
            
            
        } catch let err1 as NSError {
            error = err1
            input = nil
        }
        
        if error != nil {
            print("\(error?.localizedDescription)")
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
        
//        view.bringSubviewToFront(ResultAndAction)
        
        qrcodeframeView = UIView()
        qrcodeframeView?.layer.borderColor = UIColor.greenColor().CGColor
        qrcodeframeView?.layer.borderWidth = 2
        view.addSubview(qrcodeframeView!)
        view.bringSubviewToFront(qrcodeframeView!)
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0{
            qrcodeframeView?.frame = CGRectZero
//            ResultAndAction.setTitle("No qr code detect", forState: UIControlState.Normal)
            NSLog("Leo cay")
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObject.type == AVMetadataObjectTypeQRCode {
            
            let BarcodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrcodeframeView?.frame = BarcodeObject.bounds
            if metadataObject.stringValue != nil && k == true {
                k = false
                NSLog("hang ve")
                result = metadataObject.stringValue
                
                navigationController?.pushViewController(({
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier("plainTextVC") as! PlainTextVC
                    vc.setData(self.result)
                    return vc
                })(), animated: true)
                
            }
        }
    }
    

    

}

