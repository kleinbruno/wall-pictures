//
//  CreateOptionsViewController.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 05/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class CreateOptionsViewController: UIViewController {
    public var pictures: [Picture] = []
    
    @IBAction func colorButtonPress(_ sender: Any) {
        let viewController = TryOutViewController.instantiate(fromAppStoryboard: .TryOut)

        viewController.pictures = self.pictures
        viewController.isColorBackground = true
    
        self.navigationController?.present(viewController, animated: true)
    }
}
