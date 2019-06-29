//
//  CreationsCollectionViewCell.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class CreationsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configCell() {
        DispatchQueue.main.async {
            self.imageView.loadImage(from: "https://s3.amazonaws.com/assets.mockflow.com/app/wireframepro/company/C73f66fcea4ec476cb83a7527d49aa1ca/projects/M949561e8e6eb08470f7dd8aa9e039eae1560387191030/images/M7bdc47993667eefe2e4e7cd4eadbf2f21561600985788")
        }
    }
}
