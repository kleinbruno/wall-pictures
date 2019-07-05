//
//  Picture.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 30/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation

import Firebase

struct Picture: Codable {
    let image: String
    let width: Double
    let height: Double
}

struct Pictures: Codable {
    var pictures: [Picture] = []
    
    init(querySnapshot: QuerySnapshot?) {
        for document in querySnapshot!.documents {
            
            let image = document.getString(by: "image")
            let width = document.getDouble(by: "width")
            let height = document.getDouble(by: "height")
            
            let picture = Picture.init(image: image, width: width, height: height)
            
            self.pictures.append(picture)
        }
    }
}
