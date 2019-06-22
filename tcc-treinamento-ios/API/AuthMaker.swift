//
//  AuthMaker.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import Foundation

import Firebase

enum AuthError: Error {
    case a
}

//typealias Result<T> = AuthResult<AuthDataResult, AuthError>
//typealias CompletionCallback<T: AuthResult<AuthDataResult, AuthError>> = (Result<Any>) -> Void
//
//class AuthMaker {
//    func onRegister(email: String, password: String, completion: @escaping CompletionCallback<AuthResult>) {
//        Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>) { (<#AuthDataResult?#>, <#Error?#>) in
//            <#code#>
//        }
//
//        Auth.auth().signIn(withEmail: "", password: "") { (data, err) in
//            if let authData = data {
//                completion(authData, nil)
//            }
//        }
//
//
//        Auth.auth().createUser(withEmail: "luanwinck23@gmail.com", password: "teste123") { (authResult, error) in
//            if let error = error {
//                print(error)
//            } else {
//                print(authResult ?? "no register")
//            }
//        }
//    }
//
//    func onLogin() {
//        Auth.auth().signIn(withEmail: "luanwinck23@gmail.com", password: "teste123") { (user, error) in
//            if let error = error {
//                print(error)
//            } else {
//                print(user ?? "not uset")
//            }
//        }
//    }
}
