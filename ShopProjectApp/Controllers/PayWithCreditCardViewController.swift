//
//  PayWithCreditCardViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/19/22.
//

import UIKit

/// Sets view for the ability to pay with credit card
class PayWithCreditCardViewController: UIViewController {

    let verifier = PaymentVerification()
    @IBOutlet weak var creditCardNumber: UITextField!
    @IBOutlet weak var month: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var cvc: UITextField!
    @IBOutlet weak var cardHolder: UITextField!
    @IBOutlet weak var shippingAddress: UITextField!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    /// Sets payment for credit card
    /// - Parameter sender: button press event
    @IBAction func submit(_ sender: Any) {
        if(verifier.validateCreditCard(creditCard: creditCardNumber.text!, cvc: cvc.text!, expMonth: month.text!, expYear: year.text!, error: error) == true){
            NotificationCenter.default.post(name: Notification.Name("setCanPay"), object: nil)
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    
}
