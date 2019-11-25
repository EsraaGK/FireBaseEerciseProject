//
//  LoginViewController.swift
//  FireBaseEerciseProject
//
//  Created by EsraaGK on 11/25/19.
//  Copyright © 2019 EsraaGK. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

class LoginViewController: UIViewController, LoginButtonDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        
        // Optional: Place the button in the center of your view.
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.permissions = ["public_profile", "email"]
        if (AccessToken.current != nil) {
            // User is logged in, do work such as go to next view controller.
            let profileVC = ProfileViewController()
            self.navigationController!.pushViewController(profileVC, animated: true)
        }
        
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ...
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let _ = error {
                // ...
                return
            }
            // User is signed in
            let profileVC = ProfileViewController()
            self.navigationController!.pushViewController(profileVC, animated: true)
            // ...
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
}
