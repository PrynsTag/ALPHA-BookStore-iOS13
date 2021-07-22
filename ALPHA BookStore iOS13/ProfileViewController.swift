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
    @IBOutlet weak var usernameLabel: UILabel!
    
    let username: String? = nil
    
    var ref: DatabaseReference! = Database.database(url: "https://alpha-bookstore-ios-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    override func viewDidLoad() {
        
        ref.child(username!).observe(.value, with: { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                let name = dictionary["name"] as! String
                let email = dictionary["email"] as! String
                let username = dictionary["username"] as! String
                
                self.nameTextField.text = name
                self.emailTextField.text = email
                self.usernameLabel.text = username
            }
        })
    }
    
    @IBAction func updatePressed(_ sender: UIButton) {
        
        let new_name = nameTextField.text!
        let new_email = emailTextField.text!
        let username = usernameLabel.text!
        
        ref.child(username).updateChildValues(
            [
                "name": new_name,
                "email": new_email
            ]
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "profileToPass" {
            let vc = segue.destination as? PasswordViewController
            vc?.username = username
        }
    }
    
    @IBAction func changePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "profileToPass", sender: self)
    }
}
