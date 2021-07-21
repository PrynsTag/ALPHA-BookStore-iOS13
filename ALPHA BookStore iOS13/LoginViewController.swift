//
//  LoginViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/21/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error { print(e.localizedDescription) }
                else { self.performSegue(withIdentifier: "goToStore", sender: self) }
            }
        }
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSignup", sender: self)
    }
}
