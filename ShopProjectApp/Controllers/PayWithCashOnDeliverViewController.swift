//
//  PayWithCashOnDeliverViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/19/22.
//

import UIKit

/// Sets view for the ability to pay with cash on delivery
class PayWithCashOnDeliverViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /// Sets payment for cash on delivery
    /// - Parameter sender: button press event
    @IBAction func submit(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("setCanPay"), object: nil)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
