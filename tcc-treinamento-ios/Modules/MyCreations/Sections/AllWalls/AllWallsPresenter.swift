//
//  AllWallsPresenter.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 06/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class AllWallsPresenter: NSObject {
    weak var view: AllWallsViewController?
    
    var wallList = [Wall]()
}

extension AllWallsPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allWalls", for: indexPath)
        
        if let creationCell = cell as? AllWallsCollectionViewCell {
            creationCell.configCell(with: wallList[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let wall = self.wallList[indexPath.row]
        
        let viewController = FullWallViewController.instantiate(fromAppStoryboard: .MyCreations)
        
        viewController.presenter.wallImage = wall.image
        
        self.view?.navigationController?.show(viewController, sender: nil)

    }
}

extension AllWallsPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  32
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width:collectionViewSize/3, height: collectionViewSize/3)
    }
}

extension AllWallsPresenter: UICollectionViewDelegate {
    //Write Delegate Code Here
}

