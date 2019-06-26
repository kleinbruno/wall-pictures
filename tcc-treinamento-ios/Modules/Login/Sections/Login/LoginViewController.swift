//
//  LoginViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!

    private let authMaker = AuthMaker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
//
//        var ref: DocumentReference? = nil
//        ref = db.collection("users").document("lA6GMorYJH3m13uD3OLs").collection("pictures").addDocument(data: [
//            "name": "arteloza",
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
        
//        db.collection("users").document("UhZd9quqjO6GTw5a6smf").collection("pictures").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
        
//        db.collection("users").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
        
        db.collection("users").whereField("email", isGreaterThanOrEqualTo: "luanwinck23@gmail.com").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
            
    }
    
    @IBAction func onPressGoSignUp(_ sender: UIButton) {
        if let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "signupviewcontroller") as? SignUpViewController {
            self.show(signUpViewController, sender: nil)
//            self.navigationController?.pushViewController(signUpViewController, animated: true)
        }
    }
    
    @IBAction func onPressLogin(_ sender: UIButton) {
        if let email = self.email?.text, let password = self.password?.text {
            self.authMaker.onLogin(email: email, password: password, onSuccess: { (user) in
                
                user.user.getIDToken(completion: { (token, _) in
                    UserDefaults.standard.set(token, forKey: "userToken")
                })
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeviewcontroller") as? ViewController {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = homeViewController
                }
                
            }) { (error) in
                self.errorMessage.text = error.message
            }
        }
    }
}
