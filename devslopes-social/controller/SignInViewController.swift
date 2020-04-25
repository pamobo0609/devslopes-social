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
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
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
                self.firebaseAuthWithFacebook(credential: credentials)
            }
        })
    }
    
    @IBAction func onSignInClick(_ sender: UIButton) {
        if let email = emailAddress.text, let password = password.text {
            firebaseAuthWithUsernameAndPassword(email: email, password: password)
        }
    }
    
    func firebaseAuthWithFacebook(credential: FirebaseAuth.AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if nil != error {
                print("Unable to authenticate with Firebase due to: \(String(describing: error))")
            } else {
                print("Successfully authenticated with Firebase")
            }
        })
    }
    
    func firebaseAuthWithUsernameAndPassword(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if nil == error {
                print("Successfully authenticated with Firebase")
            } else {
                // Getting here means the user does not existe. So we'll create it.
                Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
                    if nil == error {
                        print("Successfully authenticated with Firebase")
                    } else {
                        print("Unable to authenticate with Firebase due to: \(String(describing: error))")
                    }
                })
            }
        })
    }
    
}

