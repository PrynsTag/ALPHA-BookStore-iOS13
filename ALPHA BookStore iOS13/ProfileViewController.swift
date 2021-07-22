//
//  ProfileViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/22/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = username!
    }
}

