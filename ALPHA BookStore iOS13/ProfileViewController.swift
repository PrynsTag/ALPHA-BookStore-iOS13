//
//  ProfileViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by John Christian Garon on 7/21/21.
//

import Foundation
import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    let username: String = "test"
    
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        ref.child(username).observe(.value, with: { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                let name = dictionary["name"] as! String
                let email = dictionary["email"] as! String
                let username = dictionary["username"] as! String
                
                self.nameTextField.text = name
                self.emailTextField.text = email
                self.usernameTextField.text = username
            }
        })
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        
        let name = nameTextField.text!
        let email = emailTextField.text!
        let username = usernameTextField.text!
        
        ref.child(username).updateChildValues(
            [
                "name": name,
                "email": email,
                "username": username
            ]
        )
    }
    
    @IBAction func changePasswordPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToChangePass", sender: self)
    }
}
