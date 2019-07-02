//
//  RequestMaker.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 25/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation

import Firebase

enum RequestError: Error {
    case requestFailed
    
    var message: String {
        switch self {
        case .requestFailed:
            return "Falha em obter os dados"
        }
    }
}

typealias RequestFailCallback<RequestError> = (RequestError) -> Void
typealias RequestResultCallback<T> = (T) -> Void

class RequestMaker {
    lazy var db = Firestore.firestore()
    
    let userUID = UserDefaults.standard.string(forKey: "userUID")
    
    func addPicture(withImage image: String) {
        if let userUID = UserDefaults.standard.string(forKey: "userUID") {
            self.db.collection("users").document(userUID).collection("pictures").document().setData([
                "image": image,
                ]) { (error) in
                print(error)
            }
        }
    }

    func fetchPictures(onSuccess: @escaping RequestResultCallback<Pictures>, onFailed: @escaping RequestFailCallback<RequestError>) {
        if let userUID = UserDefaults.standard.string(forKey: "userUID") {
            self.db.collection("users").document(userUID).collection("pictures").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    onFailed(.requestFailed)
                } else {
                    let pictures = Pictures.init(querySnapshot: querySnapshot)
                    
                    onSuccess(pictures)
                }
            }
            
        }
    }

    func registerUser(withUID UID: String, withName name: String, withEmail email: String) {
        self.db.collection("users").document(UID).setData([
            "name": name,
            "email": email,
            ])
    }
}



