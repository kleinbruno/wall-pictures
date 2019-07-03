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
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let allPicturesPresenter = AllPicturesPresenter()
    public var isSelectMode: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allPicturesPresenter.view = self
        
        self.allPicturesCollectionView.dataSource = self.allPicturesPresenter
        self.allPicturesCollectionView.delegate = self.allPicturesPresenter
    }
    
    @IBAction func selectButtonPress(_ sender: Any) {
        self.isSelectMode = !self.isSelectMode
        
        if (self.isSelectMode) {
            self.selectButton.setTitle("Cancelar", for: .normal)
        } else {
            self.selectButton.setTitle("Selecionar", for: .normal)
        }
    }
    
    func configScreen() {
        self.titleLabel.text = "SELECIONAR QUADROS"
    }
}
