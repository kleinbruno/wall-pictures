//
//  TryOutViewController.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 04/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class TryOutViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
//    var pictures = Picture
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
    }
}

extension TryOutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedImages", for: indexPath)
        
        if let pictureCell = cell as? PicturesCollectionViewCell {
            pictureCell.configCell()
        }
        
        return cell
    }
}
