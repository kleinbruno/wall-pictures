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

typealias RequestResult<T> = Result<T, RequestError>
typealias SuccessRequestCallback<NSDictionary> = (NSDictionary) -> Void
//typealias LoginFailCallback<AuthError> = (AuthError) -> Void
//typealias SignUpFailCallback<AuthError> = (AuthError) -> Void

class RequestMaker {
    lazy var db = Firestore.firestore()
    
    let userUID = UserDefaults.standard.string(forKey: "userUID")

    func fetchData(email: String, password: String, onSuccess: @escaping SuccessRequestCallback<NSDictionary>, onFailed: @escaping SignUpFailCallback<RequestError>) {

        self.db.collection("pictures").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                    onSuccess(document.data())

                    print("\(document.documentID) => \(document.data())")
                }
            }
        }

    }
    
    func addPicture(withImage image: String) {
        if let userUID = UserDefaults.standard.string(forKey: "userUID") {
            self.db.collection("users").document(userUID).collection("pictures").document().setData([
                "image": image,
                ])
        }
    }

    func fetchPictures() {
        if let userUID = UserDefaults.standard.string(forKey: "userUID") {
            self.db.collection("users").document(userUID).collection("pictures").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("USER PICTURES!!!!!!!!!!!")
                    
                    let pictures = Pictures.init(querySnapshot: querySnapshot)
                    
                    print(pictures)
                    
                   
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



