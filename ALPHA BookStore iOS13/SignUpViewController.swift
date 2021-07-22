//
//  SignUpViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by John Christian Garon on 7/21/21.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: DatabaseReference! = Database.database(url: "https://alpha-bookstore-ios-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    @IBAction func signupPressed(_ sender: UIButton) {
        
        let name = nameTextField.text!
        let email = emailTextField.text!
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        ref.child(username).setValue(
            [
                "name": name,
                "email": email,
                "username": username,
                "password": password
            ]
        )
        
        performSegue(withIdentifier: "signUpToLogin", sender: self)
    }
}
