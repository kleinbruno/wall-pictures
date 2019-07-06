//
//  FullWallViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 06/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class FullWallViewController: UIViewController {
    
    let presenter = FullWallPresenter()

    @IBOutlet weak var wallImage: UIImageView!
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.view = self
        
        if let image = UIImage.fromBase64(self.presenter.wallImage) {
            self.wallImage.image = image
        } else {
            self.wallImage.loadImage(from: self.presenter.wallImage)
        }
    }
}
