//
//  FeedViewController.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/25/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import UIKit
import FirebaseAuth

class FeedViewController: UIViewController {

    
    @IBOutlet weak var feedContainer: FancyView!
    @IBOutlet weak var newPostContainer: FancyView!
    @IBOutlet weak var postButton: FancyRoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedContainer.addShadow()
        newPostContainer.addShadow()
        postButton.circle()
        
    }
    
}
