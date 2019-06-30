//
//  UIImageViewExtensions.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation
import Nuke

extension UIImageView {
    
    func loadImage(from urlString: String) {
        if let url = URL(string: urlString) {
            // simplão
             Nuke.loadImage(with: url, into: self)
            
            // bonitão
//            let options = ImageLoadingOptions(placeholder: .pikachu, transition: .fadeIn(duration: 0.3), failureImage: .pikachu)
            
//            Nuke.loadImage(with: url, options: options, into: self)
        }
    }
        
}
