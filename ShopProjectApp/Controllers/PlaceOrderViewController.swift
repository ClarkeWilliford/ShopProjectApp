//
//  PlaceOrderViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/8/22.
//

import UIKit

/**
    Shows the order total, shipping, and tax prices and allows to update billing and shipping address as well as placing order actions
 */
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
    
    /// Navigates to edit shipping view
    /// To Do
    @IBAction func editShipping(_ sender: Any) {
        print("edit shipping")
    }
    /// Navigates to edit billing view
    /// To Do
    @IBAction func editBilling(_ sender: Any) {
        print("edit billing")
    }
    
    /// Saves the order in relevant variables
    /// To Do
    @IBAction func placeOrder(_ sender: Any) {
        print(GlobalVariables.itemsInCart)
        GlobalVariables.orderedItems = GlobalVariables.itemsInCart
        print(GlobalVariables.orderedItems)
        itemsWereOrdered = true
        print(itemsWereOrdered)
        print("order placed")
    }
}
