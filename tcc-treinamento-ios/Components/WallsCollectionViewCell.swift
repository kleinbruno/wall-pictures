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
    
    func configCell() {
        DispatchQueue.main.async {
            //pegar imagens do firebase
            self.imageView.loadImage(from: "https://s3.amazonaws.com/assets.mockflow.com/app/wireframepro/company/C73f66fcea4ec476cb83a7527d49aa1ca/projects/M949561e8e6eb08470f7dd8aa9e039eae1560387191030/images/M89cb3f511e7dfbead75c8d5135e0bcdb1561775426839")
        }
    }
}
