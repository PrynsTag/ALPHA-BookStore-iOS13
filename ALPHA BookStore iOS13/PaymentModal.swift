//
//  PaymentModal.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/21/21.
//

import UIKit

class PaymentModal: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        dismiss (animated: true, completion: nil)
    }
}
