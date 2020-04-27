//
//  CircleView.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/25/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import Foundation
import UIKit

protocol Circled {}

extension Circled where Self: UIButton {
    
    func circle() {
        imageView?.contentMode = .scaleAspectFit
        layer.cornerRadius = frame.width / 2 
    }
    
}

extension Circled where Self: UIImageView {
    
    func layoutSubviews() {
        layer.shadowColor = UIColor(displayP3Red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = self.frame.width / 2
    }
    
    func circle() {
        layer.cornerRadius = frame.width / 2
    }
    
}


