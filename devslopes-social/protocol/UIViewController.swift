//
//  ReusableView.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/25/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static var reuseIdentifier: String {
        return String(describing: self)
    }    
}
