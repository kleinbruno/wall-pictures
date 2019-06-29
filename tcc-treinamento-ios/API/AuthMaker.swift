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
    case invalidEmailOrPassword
    case fieldEmpty
    
    var message: String {
        switch self {
        case .invalidEmailOrPassword:
            return "Email ou senha inválidos"
        case .fieldEmpty:
            return "Preencha todos os campos"
        }
    }
}

enum ApiError: String {
    case emailExists = "The email address is already in use by another account."
    
    func getMessage(error: ApiError) -> String {
        switch error {
        case .emailExists:
            return "Email já cadastrado"
        }
    }
}

typealias SuccessCallback<AuthDataResult> = (AuthDataResult) -> Void
typealias LoginFailCallback<AuthError> = (AuthError) -> Void
typealias SignUpFailCallback<AuthError> = (AuthError) -> Void

class AuthMaker {
    func onRegister(name: String, email: String, password: String, onSuccess: @escaping SuccessCallback<AuthDataResult>, onFailed: @escaping SignUpFailCallback<AuthError>) {
        
        if (name.isEmpty || email.isEmpty || password.isEmpty) {
            onFailed(.fieldEmpty)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                onFailed(.invalidEmailOrPassword)
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
                onFailed(.invalidEmailOrPassword)
            }
            
            if let authResult = authResult {
                onSuccess(authResult)
            }
        }
    }
}
