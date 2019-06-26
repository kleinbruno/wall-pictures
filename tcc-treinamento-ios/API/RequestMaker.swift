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
    case invalidEmail
    
    var message: String {
        switch self {
        case .invalidEmail:
            return "Email inválido"
        }
    }
}

//
typealias SuccessRequestCallback<NSDictionary> = (NSDictionary) -> Void
//typealias LoginFailCallback<AuthError> = (AuthError) -> Void
//typealias SignUpFailCallback<AuthError> = (AuthError) -> Void

class RequestMaker {
    let db = Firestore.firestore()

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
    
    func registerUser(email: String) {
        self.db.collection("users").addDocument(data: ["email" : email])
    }
    
    func onLogin(email: String, password: String, onSuccess: @escaping SuccessCallback<AuthDataResult>, onFailed: @escaping LoginFailCallback<RequestError>) {
        
//        charactersDb = Firestore.firestore().collection("users").document(deviceId).collection("characters")
    }
}



