//
//  MyCustomButton.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/8/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class MyCustomButton: UIButton {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
//        self.layer.borderColor = UIColor.blue.cgColor
//        self.layer.borderWidth = 1.0
//        self.layer.cornerRadius = 5.0
//        self.clipsToBounds = true
//        self.setTitleColor(UIColor.blue, for: UIControlState.normal)
//        
//        if #available(iOS 9.0, *) {
//            self.setTitleColor(UIColor.white, for: UIControlState.focused)
//        } else {
//            // Fallback on earlier versions
//        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            
            if (isHighlighted) {
                self.backgroundColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
            }
            else {
                self.backgroundColor = UIColor.clear
            }
            
        }
    }

}
