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
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    let allPicturesPresenter = AllPicturesPresenter()
    private let createOptions = "create-options"
    
    public var isSelectMode: Bool = false
    public var selectedQuantity: Int = 0 {
        didSet {
            if (self.selectedQuantity == 0) {
                footerLabel.text = "Nenhum item selecionado"
            } else if (self.selectedQuantity == 1) {
                footerLabel.text = "\(self.selectedQuantity) item selecionado"
            } else {
                footerLabel.text = "\(self.selectedQuantity) itens selecionados"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allPicturesPresenter.view = self
        
        configInitialScreen()
        
        self.allPicturesCollectionView.dataSource = self.allPicturesPresenter
        self.allPicturesCollectionView.delegate = self.allPicturesPresenter
    }
    
    @IBAction func selectButtonPress(_ sender: Any) {
        self.isSelectMode = !self.isSelectMode
        
        if (self.isSelectMode) {
            configIsSelectMode()
        } else {
           configIsNotSelectMode()
        }
    }
    
    @IBAction func continueButtonPress(_ sender: Any) {
         let viewController = CreateOptionsViewController.instantiate(fromAppStoryboard: .Create)
        var selectedPictures: [Picture] = []
        
        if let selectedItems = allPicturesCollectionView.indexPathsForSelectedItems {
            
            for indexPath in selectedItems { selectedPictures.append(self.allPicturesPresenter.pictureList[indexPath.row])
            }
        }
        
        viewController.pictures = selectedPictures

        self.navigationController?.show(viewController, sender: sender)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func configInitialScreen() {
        self.titleLabel.text = "SELECIONAR QUADROS"
        self.footerView.isHidden = true
        self.allPicturesCollectionView.allowsSelection = false
        disableContinueButton()
    }
    
    func configIsSelectMode() {
        self.allPicturesCollectionView.allowsMultipleSelection = true
        self.selectButton.setTitle("Cancelar", for: .normal)
        self.footerView.isHidden = false
        self.footerLabel.text = "Nenhum item selecionado"
        disableContinueButton()
    }
    
    func configIsNotSelectMode() {
        self.allPicturesCollectionView.allowsSelection = false
        self.selectButton.setTitle("Selecionar", for: .normal)
        self.footerView.isHidden = true
        
        if let selectedItems = allPicturesCollectionView.indexPathsForSelectedItems {
            
            for indexPath in selectedItems {
                allPicturesCollectionView.deselectItem(at: indexPath, animated: true)
            }
        }
    }
    
    func disableContinueButton() {
        self.continueButton.isEnabled = false
        self.continueButton.alpha = 0.5
    }
    
    func enableContinueButton() {
        self.continueButton.isEnabled = true
        self.continueButton.alpha = 1
    }
}

extension AllPicturesViewController {

    func reloadSelectedQuantity() {
        self.selectedQuantity = allPicturesCollectionView.indexPathsForSelectedItems?.count ?? 0
        
        if (self.selectedQuantity > 0) {
            enableContinueButton()
        } else {
            disableContinueButton()
        }
    }
    
}

