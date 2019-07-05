//
//  PictureView.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 05/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class PictureView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func getPicture(with image: UIImage) -> UIView {
        let wrapperView = UIView(frame: self.frame)
        
        let imageView = UIImageView(image: image)
        imageView.fixInView(wrapperView)
        
        wrapperView.layer.shadowColor = UIColor.black.cgColor
        wrapperView.layer.shadowOffset = .zero
        wrapperView.layer.shadowRadius = 5
        wrapperView.layer.shouldRasterize = true
        wrapperView.layer.rasterizationScale = UIScreen.main.scale
        wrapperView.layer.shadowOpacity = 1
        
        return wrapperView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
