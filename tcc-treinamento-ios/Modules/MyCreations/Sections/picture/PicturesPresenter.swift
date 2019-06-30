//
//  File.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class PicturesPresenter: NSObject {
    weak var view: AnyObject?
}

extension PicturesPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 //pegar o .length das paredes/quadros q o user tem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictures", for: indexPath)
        
        if let creationCell = cell as? PicturesCollectionViewCell {
            creationCell.configCell()
        }
        
        return cell
    }
    
}
