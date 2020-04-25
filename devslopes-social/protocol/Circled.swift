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
