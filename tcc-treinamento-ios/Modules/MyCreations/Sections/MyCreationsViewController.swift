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
    
    private let presenter = WallsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.view = self
        
        self.wallCollectionView.dataSource = self.presenter
    }
    
}
