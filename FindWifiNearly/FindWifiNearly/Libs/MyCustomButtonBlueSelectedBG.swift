//
//  MyCustomButtonBlueSelectedBG.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/12/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class MyCustomButtonBlueSelectedBG: UIButton {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
    }
 
    override var isSelected: Bool {
        didSet {
    
            if (isSelected) {
                self.backgroundColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
            }
            else {
                self.backgroundColor = UIColor.clear
            }
            
        }
    }
}
