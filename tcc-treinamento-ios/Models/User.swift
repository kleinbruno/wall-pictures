//
//  User.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 30/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation

import Firebase

struct User: Codable {
    var name: String = ""
    var email: String = ""
    
    init(document: DocumentSnapshot) {
        
        self.name = document.getString(by: "name")
        self.email = document.getString(by: "email")
    }
    
}
