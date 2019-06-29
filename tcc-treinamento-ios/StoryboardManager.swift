//
//  UpdateRoot.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation
import UIKit

class StoryboardManager {
    
    static func updateViewController() {
//        let status = UserDefaults.standard.bool(forKey: "status")
        var root : UIViewController?
        
        if let userEmail = UserDefaults.standard.string(forKey: "userEmail") {
            root = ViewController.instantiate(fromAppStoryboard: .Main)
        } else {
            root = LoginViewController.instantiate(fromAppStoryboard: .Login)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = root
    }
}
