//
//  AllWallsViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 06/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class AllWallsViewController: UIViewController {

    @IBOutlet weak var allWallsCollectionView: UICollectionView!
    
    let presenter = AllWallsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.view = self
        
        self.allWallsCollectionView.dataSource = self.presenter
        self.allWallsCollectionView.delegate = self.presenter
        
        self.allWallsCollectionView.allowsSelection = true

    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
