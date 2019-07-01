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
            self.imageView.loadImage(from: picture.image)
        }
    }
}
