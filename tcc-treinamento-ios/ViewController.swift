//
//  ViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.onRegister()
    }
    
    func onRegister() {
        Auth.auth().createUser(withEmail: "luanwinck23@gmail.com", password: "teste123") { (authResult, error) in
            if let error = error {
                print(error)
            } else {
                print(authResult ?? "no register")
            }
        }
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

