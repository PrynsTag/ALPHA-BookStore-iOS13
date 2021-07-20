//
//  LoginViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by macos on 7/20/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func logitBtn(_ sender: Any) {
        checkLogin()
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
    }
    
    func checkLogin() {
        if username.text?.isEmpty == true {
            print("No Email Text")
            return
        }
        
        if password.text?.isEmpty == true {
            print("No Password")
            return
        }
        
        login()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: username.text!, password: password.text!)
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController(identifier: "storeStoryboard")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }

}
