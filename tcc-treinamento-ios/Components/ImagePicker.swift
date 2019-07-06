//
//  ImagePicker2.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 06/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit
import YPImagePicker

class ImagePicker {
    
    func getInstance(numberOfItens: Int) -> YPImagePicker {
        var config = YPImagePickerConfiguration()
        config.wordings.libraryTitle = "Galeria"
        config.wordings.cameraTitle = "Câmera"
        config.wordings.next = "OK"
        config.wordings.cancel = "Cancelar"
        config.wordings.done = "OK"
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = true
        config.showsPhotoFilters = true
        config.shouldSaveNewPicturesToAlbum = true
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library, .photo]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        config.library.options = nil
        config.library.onlySquare = false
        config.library.minWidthForItem = nil
        config.library.mediaType = .photo
        config.library.maxNumberOfItems = numberOfItens
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = false
        return YPImagePicker(configuration: config)
    }
    
}
