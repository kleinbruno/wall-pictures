//
//  MyCreationsPresenter.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class WallsPresenter: NSObject {
    weak var view: MyCreationsViewController?
    
    var wallList = [Wall]()
    
    private let requestMaker = RequestMaker()
    
    func fetchData() {
        self.requestMaker.fetchWalls(onSuccess: { (walls) in
            self.wallList = walls.walls
            
            DispatchQueue.main.async {
                self.view?.reloadWalls()
            }
        }) { (error) in
            print(error)
        }
    }
}

extension WallsPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wallList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "walls", for: indexPath)
        
        if let creationCell = cell as? WallsCollectionViewCell {
            creationCell.configCell(with: wallList[indexPath.item])
        }
        
        return cell
    }
    
}
