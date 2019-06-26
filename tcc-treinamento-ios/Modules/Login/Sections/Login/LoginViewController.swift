//
//  LoginViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!

    private let authMaker = AuthMaker()

    override func viewDidLoad() {
        super.viewDidLoad()  
    }
    
    @IBAction func onPressGoSignUp(_ sender: UIButton) {
        if let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "signupviewcontroller") as? SignUpViewController {
            self.show(signUpViewController, sender: nil)
//            self.navigationController?.pushViewController(signUpViewController, animated: true)
        }
    }
    
    @IBAction func onPressLogin(_ sender: UIButton) {
        if let email = self.email?.text, let password = self.password?.text {
            self.authMaker.onLogin(email: email, password: password, onSuccess: { (user) in
                
                user.user.getIDToken(completion: { (token, _) in
                    UserDefaults.standard.set(token, forKey: "userToken")
                })
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeviewcontroller") as? ViewController {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = homeViewController
                }
                
            }) { (error) in
                self.errorMessage.text = error.message
            }
        }
    }
}
