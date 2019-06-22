//
//  SignUpViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmationPassword: UITextField!
    @IBOutlet weak var errorMessage: UILabel!

    private let authMaker = AuthMaker()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onPressGoLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressSignUp(_ sender: UIButton) {
        if let email = self.email?.text, let password = self.password?.text {
            self.authMaker.onRegister(email: email, password: password, onSuccess: { (user) in
                
                user.user.getIDToken(completion: { (token, _) in
                    UserDefaults.standard.set(token, forKey: "userToken")
                })
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeviewcontroller") as? ViewController {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = homeViewController
                }
                
            }) { (error) in
                print(error)
                print("ERROOOOOOOOOOOO")
                self.errorMessage.text = "Invalid email or password"
            }
        }
    }

}
