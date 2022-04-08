//
//  PlaceOrderViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/7/22.
//

import UIKit

class PlaceOrderViewController: UIViewController {

    var initialPrice = 0.0
    var shippingPrice = 0.0
    var taxPrice = 0.0
    var total = 0.0
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var shippingAndHandling: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var shippingAddress: UILabel!
    @IBOutlet weak var billingInfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(initialPrice)
        items.text = "Items: $\(initialPrice)"
        if(initialPrice >= 200.0){
            shippingPrice = 10.00
            shippingAndHandling.text = "Shipping & Handling: $10.00"
        } else{
            shippingPrice = 0.0
            shippingAndHandling.text = "Shipping & Handling: Free shipping"
        }
        taxPrice = 0.0875*initialPrice
        tax.text = String(format: "Tax: $%.2f",taxPrice)
        total = initialPrice + shippingPrice + taxPrice
        orderTotal.text = String(format: "Order Total: $%.2f",total)
        
    }
    
    @IBAction func placeOrder(_ sender: Any) {
        print("go to orders")
    }
    @IBAction func goToEditShipping(_ sender: Any) {
        print("go to edit shipping")
    }
    
    @IBAction func goToEditBilling(_ sender: Any) {
        print("go to edit billing")
    }
}
