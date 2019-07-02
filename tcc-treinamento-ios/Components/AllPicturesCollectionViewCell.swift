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
    
    func configCell() {
        DispatchQueue.main.async {
            //pegar imagens do firebase
            self.imageView.loadImage(from: "https://s3.amazonaws.com/assets.mockflow.com/app/wireframepro/company/C73f66fcea4ec476cb83a7527d49aa1ca/projects/M949561e8e6eb08470f7dd8aa9e039eae1560387191030/images/M46c2e259fc2d3b1a3c236d22c8c04c311561599549352")
        }
    }
}
