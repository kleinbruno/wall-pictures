//
//  AllWallsCollectionViewCell.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 06/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class AllWallsCollectionViewCell: UICollectionViewCell {

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
