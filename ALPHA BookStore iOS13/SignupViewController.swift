//
//  SignupViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by John Christian Garon on 7/20/21.
//

import Foundation
import UIKit
import FirebaseDatabase

class SignupViewController : UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signupPressed(_ sender: UIButton) {
        
        let ref: DatabaseReference! = Database.database(url: "https://alpha-bookstore-ios-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        let name = nameTextField.text!
        let email = emailTextField.text!
        let username = usernameTextField.text!
        let password = passwordTextField.text!

        ref.child(name).getData { [self] (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                
                print(snapshot.value!)

                let messageVC = UIAlertController(title: "Message Title", message: "Account Created successfully" , preferredStyle: .actionSheet)

                self.present(messageVC, animated: true) { Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in messageVC.dismiss(animated: true, completion: nil)})}
            }
            else {

                ref.child(name).setValue(
                    [
                        "name": name,
                        "email": email,
                        "username": username,
                        "password": password
                    ]
                )
            }
        }
    }
}
