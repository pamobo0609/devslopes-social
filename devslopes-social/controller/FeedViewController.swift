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

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func onSignOutClick(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            print("Successfully logged out from Firebase.")
            dismiss(animated: true, completion: nil)
        } catch {
            print("Unable to sign out from Firebase due to: \(error.localizedDescription)")
        }
    }
    
}
