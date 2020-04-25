//
//  ViewController.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/25/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var header: FancyView!
    @IBOutlet weak var facebookLoginButton: FancyRoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.addShadow()
        facebookLoginButton.addShadow()
        facebookLoginButton.circle()
        
    }


}

