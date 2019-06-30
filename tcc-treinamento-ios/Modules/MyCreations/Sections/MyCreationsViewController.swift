//
//  MyCreationsViewController.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class MyCreationsViewController: UIViewController {
    
    @IBOutlet weak var wallCollectionView: UICollectionView!
    @IBOutlet weak var pictureCollectionView: UICollectionView!
    
    private let wallsPresenter = WallsPresenter()
    private let picturesPresenter = PicturesPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wallsPresenter.view = self
        self.picturesPresenter.view = self
        
        self.wallCollectionView.dataSource = self.wallsPresenter
        self.pictureCollectionView.dataSource = self.picturesPresenter
    }
    
}
