//
//  AuthenticationVC.swift
//  ForestAdventures
//
//  Created by Brandi Bailey on 4/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

enum LoginType {
    case signIn
    case signUp
}

class AuthenticationVC: UIViewController {
    
    var apiController: APIController?
    var loginType = LoginType.signIn

    @IBOutlet weak var authSegmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.setTitle("Sign In", for: .normal)
    }
    
    @IBAction func signInTypeChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            loginType = .signIn
            submitButton.setTitle("Sign In", for: .normal)
        } else {
            loginType = .signUp
            submitButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        guard let apiController = apiController else { return }
        
        guard let username = usernameTextField.text,
            !username.isEmpty,
        let userPassword = passwordTextField.text,
            !userPassword.isEmpty else { return }
        
        print("Sup...")

        let user = User(id: nil, username: username, email: "", password: userPassword)

        if loginType == .signIn {
            apiController.signIn(with: user) { error in
                if let error = error {
                    print("There was a problem signing in: \(error)")
                } else {
                    DispatchQueue.main.async {
                        print("hello")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
}
 
