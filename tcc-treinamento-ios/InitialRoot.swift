//
//  UpdateRoot.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation
import UIKit

class InitialRoot {
    
    static func updateRootViewController(){
//        let status = UserDefaults.standard.bool(forKey: "status")
        var root : UIViewController?
        
        if(true){
            root = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeviewcontroller") as! ViewController
        }else{
            root = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginviewcontroller") as! LoginViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = root
    }
    
}
