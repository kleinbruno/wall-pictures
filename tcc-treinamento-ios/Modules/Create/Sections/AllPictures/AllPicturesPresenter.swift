//
//  AllPicturesViewController.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 01/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class AllPicturesPresenter: NSObject {
    weak var view: AnyObject?
}

extension AllPicturesPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30 //pegar o .length dos quadros q o user tem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allPictures", for: indexPath)
        
        if let creationCell = cell as? AllPicturesCollectionViewCell {
            creationCell.configCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  32
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
    
}
