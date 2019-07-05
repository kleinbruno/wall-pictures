//
//  DocumentSnapshot.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 30/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation

import Firebase

extension DocumentSnapshot {
    
    func getString(by key: String) -> String {
        return self.get(key) as? String ?? ""
    }
    
    func getDouble(by key: String) -> Double {
        return self.get(key) as? Double ?? 0
    }
    
}
