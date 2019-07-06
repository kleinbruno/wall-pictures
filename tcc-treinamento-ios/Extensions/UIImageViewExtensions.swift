//
//  UIImageViewExtensions.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation
import Nuke

extension UIImage {
    static let wall = UIImage(named: "default_wall")!
}

extension UIImageView {
    
    func loadImage(from urlString: String) {
        if let url = URL(string: urlString) {
            let options = ImageLoadingOptions(placeholder: .wall, transition: .fadeIn(duration: 0.3), failureImage: .wall)
            
            Nuke.loadImage(with: url, options: options, into: self)
        }
    }
        
}
