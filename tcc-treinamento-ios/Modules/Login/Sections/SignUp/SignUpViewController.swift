//
//  SignUpViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmationPassword: UITextField!
    @IBOutlet weak var errorMessage: UILabel!

    private let authMaker = AuthMaker()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onPressGoLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
