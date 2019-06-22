//
//  AppStoryboard.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    
    case Main
    case Login
    case MyPictures
    case MyWalls
    case TryOut
    
    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}
