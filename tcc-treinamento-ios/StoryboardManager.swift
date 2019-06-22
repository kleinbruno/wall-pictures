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
    
    static func updateViewController(){
//        let status = UserDefaults.standard.bool(forKey: "status")
        var root : UIViewController?
        
        if(true){
            root = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "homeviewcontroller") as! ViewController
        }else{
            root = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: "loginviewcontroller") as! LoginViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = root
    }
}

enum AppStoryboard: String {
    case Main = "Main"
    case Login = "Login"
    case MyPictures = "MyPictures"
    case MyWalls = "MyWalls"
    case TryOut = "TryOut"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
