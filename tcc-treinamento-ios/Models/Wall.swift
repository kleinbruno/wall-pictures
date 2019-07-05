//
//  Wall.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 04/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation

import Firebase

struct Wall: Codable {
    let image: String
}

struct Walls: Codable {
    var walls: [Wall] = []
    
    init(querySnapshot: QuerySnapshot?) {
        for document in querySnapshot!.documents {
            
            let image = document.getString(by: "image")
            
            let wall = Wall.init(image: image)
            
            self.walls.append(wall)
        }
    }
}
