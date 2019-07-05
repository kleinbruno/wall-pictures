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
    case emailExists
    
    var message: String {
        switch self {
        case .invalidEmailOrPassword:
            return "Email ou senha inválidos"
        case .fieldEmpty:
            return "Preencha todos os campos"
        case .emailExists:
            return "Email já cadastrado"
        }
    }
}

enum ApiError: String {
    case emailExists = "The email address is already in use by another account."
    
    func getMessage(error: String) -> AuthError {
        switch error {
        case ApiError.emailExists.rawValue:
            return .emailExists
        default:
            return .invalidEmailOrPassword
        }
    }
}

typealias SuccessCallback<AuthDataResult> = (AuthDataResult) -> Void
typealias LoginFailCallback<AuthError> = (AuthError) -> Void
typealias SignUpFailCallback<AuthError> = (AuthError) -> Void

class AuthMaker {
    let requestMaker = RequestMaker()
    
    func onRegister(name: String, email: String, password: String, onSuccess: @escaping SuccessCallback<AuthDataResult>, onFailed: @escaping SignUpFailCallback<AuthError>) {
        
        if (name.isEmpty || email.isEmpty || password.isEmpty) {
            onFailed(.fieldEmpty)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                if error.localizedDescription == ApiError.emailExists.rawValue {
                   onFailed(.emailExists)
                } else {
                    onFailed(.invalidEmailOrPassword)
                }
            }
            
            if let authResult = authResult {
                let userUID = authResult.user.uid
                
                self.setUserDefaults(withUID: userUID)
                self.requestMaker.registerUser(withUID: userUID, withName: name, withEmail: email)
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
                self.setUserDefaults(withUID: authResult.user.uid)
                onSuccess(authResult)
            }
        }
    }
    
    func onLogout() {
        setUserDefaults(withUID: "")
    }
    
    private func setUserDefaults(withUID UID: String?) {
        UserDefaults.standard.set(UID, forKey: "userUID")
    }
}
