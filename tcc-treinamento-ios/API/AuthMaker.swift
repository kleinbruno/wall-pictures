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
    case invalidEmail
}

typealias SuccessCallback<AuthDataResult> = (AuthDataResult) -> Void
typealias LoginFailCallback<AuthError> = (AuthError) -> Void
typealias SignUpFailCallback<AuthError> = (AuthError) -> Void

class AuthMaker {
    func onRegister(email: String, password: String, onSuccess: @escaping SuccessCallback<AuthDataResult>, onFailed: @escaping SignUpFailCallback<AuthError>) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                onFailed(.invalidEmail)
            }
            
            if let authResult = authResult {
                onSuccess(authResult)
            }
        }
    }

    func onLogin(email: String, password: String, onSuccess: @escaping SuccessCallback<AuthDataResult>, onFailed: @escaping LoginFailCallback<AuthError>) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error {
                print(error.localizedDescription)
                onFailed(.invalidEmail)
            }
            
            if let authResult = authResult {
                onSuccess(authResult)
            }
        }
    }
}

