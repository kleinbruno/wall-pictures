//
//  AllPicturesPresenter.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 01/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class AllPicturesViewController: UIViewController {
    
    @IBOutlet weak var allPicturesCollectionView: UICollectionView!
    
    private let allPicturesPresenter = AllPicturesPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allPicturesPresenter.view = self
        
        self.allPicturesCollectionView.dataSource = self.allPicturesPresenter
        self.allPicturesCollectionView.delegate = self.allPicturesPresenter
    }
    
}
