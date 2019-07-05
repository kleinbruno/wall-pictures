//
//  UIImageExtensions.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

extension UIImage {
    func toBase64(format: ImageFormat) -> String? {
        var imageData: Data?
        
        switch format {
        case .png:
            imageData = self.pngData()
        case .jpeg(let compression):
            imageData = self.jpegData(compressionQuality: compression)
        }
        
        return imageData?.base64EncodedString()
    }
    
    static func fromBase64(_ base64String: String) -> UIImage? {
        if let data = Data(base64Encoded: base64String) {
            return UIImage(data: data)
        }
        
        return nil
    }
    
    enum ImageFormat {
        case png
        case jpeg(CGFloat)
    }
}
