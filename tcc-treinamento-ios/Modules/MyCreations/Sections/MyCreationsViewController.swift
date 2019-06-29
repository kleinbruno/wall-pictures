//
//  MyCreationsViewController.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class MyCreationsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter = MyCreationsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.view = self
        
        self.collectionView.dataSource = self.presenter
        
//        CreationsCollectionViewCell.configCell()
    }
    
}
