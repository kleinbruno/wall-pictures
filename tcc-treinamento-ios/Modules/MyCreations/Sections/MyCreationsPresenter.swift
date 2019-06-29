//
//  MyCreationsPresenter.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class MyCreationsPresenter: NSObject {
    weak var view: AnyObject?
}

extension MyCreationsPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "creation", for: indexPath)
        
        if let creationCell = cell as? CreationsCollectionViewCell {
            creationCell.configCell()
        }
        
        return cell
    }
    
    
}
