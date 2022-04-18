//
//  PlaceOrderViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/8/22.
//

import UIKit
import SwiftUI

/**
    Shows the order total, shipping, and tax prices and allows to update billing and shipping address as well as placing order actions
 */
class PlaceOrderViewController: UIViewController {

    //variables to hold the various prices and tax info.
    var initialPrice = 0.0
    var shippingPrice = 0.0
    var taxPrice = 0.0
    var total = 0.0
    
    
    
    //Outlet Block
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var shippingAndHandling: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var shippingAddress: UILabel!
    @IBOutlet weak var billingInfo: UILabel!
    
    //create an object for the DBHelper class.
    var database = DBHelper()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //opens the database.
        database.OpenDatabase()
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
        let swiftUIController = UIHostingController(rootView: LoginView())
        
        if GlobalVariables.userLoggedIn.name == "" {
            //present the Swift UI conteroller modally, not fullscreen.
            self.present(swiftUIController, animated: true, completion: nil)
        }
        else{
        GlobalVariables.orderedItems = GlobalVariables.itemsInCart
        itemsWereOrdered = true
        print("order placed")
            
        //for loop to add the ordered items into the database.
        for item in GlobalVariables.orderedItems{
            database.insertUserOrders(userID: GlobalVariables.userLoggedIn.id, itemID: item.id)
            }
        
        //for loop to put any wishlist items into the database.
        for items in GlobalVariables.itemsInWishlist{
            database.insertUserWishlist(userID: GlobalVariables.userLoggedIn.id, itemID: items.id)
        }
            
        //for loop to put any history items into the database.
        for items in GlobalVariables.userHistory{
            database.insertUserHistory(userID: GlobalVariables.userLoggedIn.id, itemID: items.id)
        }
            
        //Call from Navigation class to send the user to the profile.
            Navigation.goToProfile()
        }
            
    }
}
