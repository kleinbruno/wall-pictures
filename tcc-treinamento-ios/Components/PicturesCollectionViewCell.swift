//
//  PicturesCollectionViewCell.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class PicturesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configCell(with picture: Picture) {
        
        DispatchQueue.main.async {
            if let image = UIImage.fromBase64(picture.image) {
                self.imageView.image = image
            } else {
                self.imageView.loadImage(from: picture.image)
            }
        }
    }
}
