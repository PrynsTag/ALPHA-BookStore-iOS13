//
//  PasswordViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by John Christian Garon on 7/21/21.
//

import Foundation
import UIKit
import Firebase

class PasswordViewController: UIViewController{
    
    
    @IBOutlet weak var currPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let username: String = "test"
    
    var ref: DatabaseReference! = Database.database().reference()
    
    @IBAction func changePressed(_ sender: UIButton) {
        
        let currPass = currPasswordTextField.text!
        let newPass = newPasswordTextField.text!
        let confirmPass = confirmPasswordTextField.text!
        
        if newPass == confirmPass {
            
            ref.child(username).observe(.value, with: { snapshot in
                if let dictionary = snapshot.value as? [String: Any] {
                    let db_password = dictionary["password"] as! String
                    
                    if db_password == currPass {
                        changePass(funcRef: self.ref, funcUsername: self.username, funcPassword: newPass)
                    } else {
                        print("Incorrect Password")
                    }
                }
            })
            
        } else {
            print("New Password and Confirm Password do not match")
        }
    }
}

func changePass(funcRef: DatabaseReference!, funcUsername: String, funcPassword: String) {
    funcRef.child(funcUsername).updateChildValues(
        [
            "password": funcPassword
        ]
    )
}
