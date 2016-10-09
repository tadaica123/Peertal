//
//  MyCustomCircleImageView.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/8/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class MyCustomCircleImageView: UIImageView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
