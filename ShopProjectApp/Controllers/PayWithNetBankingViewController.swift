//
//  PayWithNetBankingViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/19/22.
//

import UIKit

class PayWithNetBankingViewController: UIViewController {

    let verifier = NetBankVerification()
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var month: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var pin: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submit(_ sender: Any) {
        if(verifier.validateNetBank(accountNumber: accountNumber.text!, expMonth: month.text!, expYear: year.text!, pin: pin.text!, error: error) == true){
            NotificationCenter.default.post(name: Notification.Name("setCanPay"), object: nil)
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
}
