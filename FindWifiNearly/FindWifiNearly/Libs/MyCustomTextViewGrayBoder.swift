//
//  MyCustomTextFieldGrayBoder.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/11/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class MyCustomTextViewGrayBoder: UITextView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1).cgColor
    }


}
