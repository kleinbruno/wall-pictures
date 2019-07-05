//
//  File.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class PicturesPresenter: NSObject {
    weak var view: MyCreationsViewController?
    
    private var pictureList = [Picture]()
    
    private let requestMaker = RequestMaker()
    
    func fetchData() {
        self.requestMaker.fetchPictures(onSuccess: { (pictures) in
            self.pictureList = pictures.pictures
            
            DispatchQueue.main.async {
                self.view?.reloadPictures()
            }
        }) { (error) in
            print(error)
        }
    }
}

extension PicturesPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictures", for: indexPath)
        
        if let creationCell = cell as? PicturesCollectionViewCell {
            creationCell.configCell(with: pictureList[indexPath.item])
        }
        
        return cell
    }
    
}
