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

enum CollectionImageTypes: String {
    case pictures
    case walls
}

typealias RequestFailCallback<RequestError> = (RequestError) -> Void
typealias RequestResultCallback<T> = (T) -> Void

class RequestMaker {
    lazy var db = Firestore.firestore()
    
    let userUID = UserDefaults.standard.string(forKey: "userUID")
    
    
    func uploadImage(with image: UIImage?, width: Double, height: Double, into: CollectionImageTypes, onSuccess: @escaping () -> Void, onFail: @escaping () -> Void) {
        if let userUID = UserDefaults.standard.string(forKey: "userUID"),
            let base64 = image?.toBase64(format: .jpeg(0.1)) {
            
            self.db.collection("users").document(userUID).collection(into.rawValue).document().setData([
                "image": base64,
                "width": width,
                "height": height,
            ]) { (error) in
                if error != nil {
                    onFail()
                } else {
                    onSuccess()
                }
            }
        }
    }
    
    func uploadImage(with image: UIImage?, into: CollectionImageTypes, onSuccess: @escaping () -> Void, onFail: @escaping () -> Void) {
        if let userUID = UserDefaults.standard.string(forKey: "userUID"),
            let base64 = image?.toBase64(format: .jpeg(0.1)) {
            
            self.db.collection("users").document(userUID).collection(into.rawValue).document().setData([
                "image": base64,
            ]) { (error) in
                if error != nil {
                    onFail()
                } else {
                    onSuccess()
                }
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
    
    func fetchWalls(onSuccess: @escaping RequestResultCallback<Walls>, onFailed: @escaping RequestFailCallback<RequestError>) {
        if let userUID = UserDefaults.standard.string(forKey: "userUID") {
            self.db.collection("users").document(userUID).collection("walls").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    onFailed(.requestFailed)
                } else {
                    let walls = Walls.init(querySnapshot: querySnapshot)
                    
                    onSuccess(walls)
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
