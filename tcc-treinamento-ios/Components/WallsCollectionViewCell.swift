//
//  CreationsCollectionViewCell.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class WallsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configCell(with wall: Wall) {
        
        DispatchQueue.main.async {
            if let image = UIImage.fromBase64(wall.image) {
                self.imageView.image = image
            } else {
                self.imageView.loadImage(from: wall.image)
            }
        }
    }
}
