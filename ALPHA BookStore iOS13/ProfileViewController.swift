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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    let username = "test"
    
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        ref.child(username).observe(.value, with: { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                let name = dictionary["name"] as! String
                let username = dictionary["username"] as! String
                let email = dictionary["email"] as! String
                
                self.nameTextField.text = name
                self.usernameTextField.text = username
                self.emailTextField.text = email
            }
        })
    }
    
    @IBAction func updatePressed(_ sender: UIButton) {
        
        let new_name  = nameTextField.text!
        let new_username = usernameTextField.text!
        let new_email = emailTextField.text!
        
        ref.child(username).updateChildValues(
            ["name": new_name,
             "username": new_username,
             "email": new_email
            ]
        )
    }
}
