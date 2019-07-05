//
//  CreateWallViewController.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class CreateWallViewController: UIViewController {
    
    @IBAction func addView(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CreateWallViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {}
}
