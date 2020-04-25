//
//  ViewController.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/25/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var header: FancyView!
    @IBOutlet weak var facebookLoginButton: FancyRoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.addShadow()
        facebookLoginButton.addShadow()
        facebookLoginButton.circle()
        
    }

    @IBAction func onFacebookLoginClick(_ sender: FancyRoundButton) {
        let facebookLogin = LoginManager()
        facebookLogin.logIn(permissions: ["email"], from: self, handler: { (result, error) in
            if nil != error {
                print("Unable to auth with Facebook")
            } else if true == result?.isCancelled {
                print("User cancelled Facebook auth")
            } else {
                print("Successfully logged in with Facebook")
                let credentials = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                self.firebaseAuthenticationWithFacebook(credential: credentials)
            }
        })
    }
    
    func firebaseAuthenticationWithFacebook(credential: FirebaseAuth.AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if nil != error {
                print("Unable to auth with Firebase due to: \(String(describing: error))")
            } else {
                print("Successfully auth with Firebase")
            }
        })
    }
    
}

