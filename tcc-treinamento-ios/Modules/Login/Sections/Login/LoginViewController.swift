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
    
    @IBOutlet weak var email: UITextInput!
    @IBOutlet weak var password: UITextInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func onPressLogin(_ sender: UIButton) {
        self.email?.text(in: 3)
    }
    
    func onLogin() {
        Auth.auth().signIn(withEmail: "luanwinck23@gmail.com", password: "teste123") { (user, error) in
            if let error = error {
                print(error)
            } else {
                print(user ?? "not uset")
            }
        }
    }
}
