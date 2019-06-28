//
//  UIViewControllerExtensions.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

