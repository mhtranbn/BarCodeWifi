//
//  MaterialView.swift
//  BarCodeWifi
//
//  Created by mhtran on 4/17/16.
//  Copyright © 2016 mhtran. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOWN_COLOR, green: SHADOWN_COLOR, blue: SHADOWN_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.grayColor().CGColor
        
    }

}
