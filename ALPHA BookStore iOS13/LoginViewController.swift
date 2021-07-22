//
//  LoginViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/21/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: DatabaseReference! = Database.database(url: "https://alpha-bookstore-ios-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            self.ref.child("\(username)/").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error.localizedDescription)")
                } else if snapshot.exists() {
                    let value = snapshot.value as? NSDictionary
                    let dbPassword = value?["password"] as? String ?? ""
                    if dbPassword == password {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "goToStore", sender: self)
                        }
                    }
                } else {
                    print("No data available")
                }
            }
        }
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSignup", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStore" {
            if let username = usernameTextField.text {
                let destinationVC = segue.destination as! StoreViewController
                destinationVC.username = username
            }
        } 
    }
}
