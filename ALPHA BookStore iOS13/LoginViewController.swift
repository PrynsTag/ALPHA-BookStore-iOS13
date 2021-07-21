//
//  LoginViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/21/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToStore", sender: self)
    }
}
