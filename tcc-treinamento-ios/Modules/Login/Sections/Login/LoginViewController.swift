//
//  LoginViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func onPressLogin(_ sender: UIButton) {
        if let email = self.email?.text, let password = self.password?.text {
            onLogin(email: email, password: password)
        }
    }
    
    func onLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error)
            } else {
                print(user ?? "not uset")
            }
        }
    }
}
