//
//  AllPicturesViewController.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 01/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class AllPicturesPresenter: NSObject {
    weak var view: AllPicturesViewController?
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        cell.addGestureRecognizer(tap)
        
        return cell
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard sender.view != nil else { return }
        
        if let creationCell = sender.view as? AllPicturesCollectionViewCell,
            let view = self.view,
            view.isSelectMode {
            
            creationCell.isSelected = !creationCell.isSelected
        }
    }
}

extension AllPicturesPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  32
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width:collectionViewSize/3, height: collectionViewSize/3)
    }
}

extension AllPicturesPresenter: UICollectionViewDelegate {
    //Write Delegate Code Here
}
