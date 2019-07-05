//
//  ConfigurationViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 05/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    let requestMaker = RequestMaker()
    let authMaker = AuthMaker()

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestMaker.fetchUserInformations(onSuccess: { (user) in
            self.userName.text = user.name
            self.userEmail.text = user.email
        }) { (RequestError) in }
    }
    
    @IBAction func onPressLogout(_ sender: Any) {
        let login = LoginViewController.instantiate(fromAppStoryboard: .Login)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = login
        
        authMaker.onLogout()
    }
    
}
