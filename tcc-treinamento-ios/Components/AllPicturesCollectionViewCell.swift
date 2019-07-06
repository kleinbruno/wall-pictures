//
//  AllPicturesCollectionView.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 01/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class AllPicturesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var checkIcon: UIImageView!
    
    func configCell(with picture: Picture) {
        
        DispatchQueue.main.async {
            if let image = UIImage.fromBase64(picture.image) {
                self.imageView.image = image
            } else {
                self.imageView.loadImage(from: picture.image)
            }
            
            self.checkIcon.isHidden = true
        }
    }
    
    override var isSelected: Bool {
        didSet {
           checkIcon.isHidden = !self.isSelected
        }
    }
    
}
