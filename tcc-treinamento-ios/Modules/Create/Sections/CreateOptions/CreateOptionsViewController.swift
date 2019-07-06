//
//  CreateOptionsViewController.swift
//  tcc-treinamento-ios
//
//  Created by Bruno Klein on 05/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit
import YPImagePicker

class CreateOptionsViewController: UIViewController {
    public var pictures: [Picture] = []
    
    @IBAction func imageARPress(_ sender: Any) {
        let viewController = ARViewController.instantiate(fromAppStoryboard: .TryOut)
        
        viewController.pictures = self.pictures
        
        self.navigationController?.present(viewController, animated: true)
    }
    
    @IBAction func imageButtonPress(_ sender: UIButton) {
        let imagePicker = ImagePicker().getInstance(numberOfItens: 1)
        let viewController = TryOutViewController.instantiate(fromAppStoryboard: .TryOut)
        
        imagePicker.didFinishPicking() {
            (items: [YPMediaItem], cancelled) in
                if let photo = items.singlePhoto {
                    let image = photo.modifiedImage ?? photo.originalImage
                    
                    viewController.pictures = self.pictures
                    viewController.backgroundImage = image
                }
                
            imagePicker.dismiss(animated: true) {
                if !cancelled {
                    self.navigationController?.present(viewController, animated: true)                    
                }
            }
        }
            
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func colorButtonPress(_ sender: Any) {
        let viewController = TryOutViewController.instantiate(fromAppStoryboard: .TryOut)

        viewController.pictures = self.pictures
        viewController.isColorBackground = true
    
        self.navigationController?.present(viewController, animated: true)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
