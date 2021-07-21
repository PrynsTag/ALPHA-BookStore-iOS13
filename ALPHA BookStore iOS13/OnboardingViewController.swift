//
//  OnboardingViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/17/21.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func getStartedPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
}

