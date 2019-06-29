//
//  LoginViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var inputsMaxConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputsMinConstraint: NSLayoutConstraint!
    
    var isSignUp = false
    
    private let authMaker = AuthMaker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configInitialLayout()
    }
    
    func configInitialLayout() {
        self.inputsMaxConstraint.priority = UILayoutPriority(rawValue: 900)
        
        self.inputsMinConstraint.priority =
            UILayoutPriority(rawValue: 999)
        
        self.name.alpha = 0
        self.loader.isHidden = true
    }
    
    func setLoader(isLoading: Bool) {
        if isLoading {
            self.loader.isHidden = false
            self.actionButton.setTitle("", for: UIControl.State.init())
        } else {
            self.loader.isHidden = true
            let textButton = self.isSignUp ? "Cadastrar" : "Entrar"
            self.actionButton.setTitle(textButton, for: UIControl.State.init())
        }
    }
    
    @IBAction func onPressAction(_ sender: UIButton) {
        self.errorMessage.text = ""
        self.isSignUp ? self.signUp() : self.login()
    }
    
    
    @IBAction func onPressSignUp(_ sender: UIButton) {
        self.isSignUp = true
        self.errorMessage.text = ""

        DispatchQueue.main.async {
            self.inputsMaxConstraint.priority = UILayoutPriority(rawValue: 999)
            
            self.inputsMinConstraint.priority = UILayoutPriority(rawValue: 900)
                        
            UIView.animate(withDuration: 1, animations: {
                self.signUpButton.alpha = 1
                self.loginButton.alpha = 0.5
                self.name.alpha = 1
                self.actionButton.setTitle("Cadastrar", for: UIControl.State.init())
                
                self.view.layoutIfNeeded()

            })
            
        }
    }
    
    @IBAction func onPressLogin(_ sender: UIButton) {
        self.isSignUp = false
        self.errorMessage.text = ""

        DispatchQueue.main.async {
            self.inputsMaxConstraint.priority = UILayoutPriority(rawValue: 900)
            
            self.inputsMinConstraint.priority = UILayoutPriority(rawValue: 999)
            
            UIView.animate(withDuration: 1, animations: {
                self.loginButton.alpha = 1
                self.signUpButton.alpha = 0.5
                self.name.alpha = 0
                self.actionButton.setTitle("Entrar", for: UIControl.State.init())
                
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    func login() {
        if let email = self.email?.text, let password = self.password?.text {
            self.setLoader(isLoading: true)

            self.authMaker.onLogin(email: email, password: password, onSuccess: { (user) in
                
                user.user.getIDToken(completion: { (token, _) in
                    UserDefaults.standard.set(token, forKey: "userToken")
                })
                
                self.goToHome()
                
            }) { (error) in
                self.setLoader(isLoading: false)
                self.errorMessage.text = error.message
            }
        }
    }
    
    func signUp() {
        if let name = self.name?.text, let email = self.email?.text, let password = self.password?.text {
            self.setLoader(isLoading: true)

            self.authMaker.onRegister(name: name, email: email, password: password, onSuccess: { (user) in
                
                user.user.getIDToken(completion: { (token, _) in
                    UserDefaults.standard.set(token, forKey: "userToken")
                })
                
                self.goToHome()
                
            }) { (error) in
                self.setLoader(isLoading: false)
                self.errorMessage.text = error.message
            }
        }
    }
    
    func goToHome() {
        let homeViewController = ViewController.instantiate(fromAppStoryboard: .Main)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeViewController
    }
}
