//
//  PlaceOrderViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/8/22.
//

import UIKit
import SwiftUI
import DropDown

/**
    Shows the order total, shipping, and tax prices and allows to update billing and shipping address as well as placing order actions
 */
class PlaceOrderViewController: UIViewController {

    //variables to hold the various prices and tax info.
    var initialPrice = 0.0
    var shippingPrice = 0.0
    var taxPrice = 0.0
    var total = 0.0
    var canPay = false
    
    
    //Outlet Block
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var shippingAndHandling: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var error: UILabel!
    
    //create an object for the DBHelper class.
    var database = DBHelper()

    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "Net Banking",
            "Cash on Delivery",
            "Credit Card",
        ]
        return menu
    }()
    
    @IBOutlet weak var showOptionsButton: UIButton!
    
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
        menu.anchorView = showOptionsButton
        NotificationCenter.default.addObserver(self, selector: #selector(setCanPay), name: Notification.Name("setCanPay"), object: nil)
    }
    
    @objc func setCanPay(){
        canPay = true
    }
    
    @IBAction func showMenu(_ sender: Any) {
        menu.show()
        menu.selectionAction = {
            index, title in
            var identifier: String?
            switch title{
                case "Net Banking":
                    identifier = "netBankingPage"
                case "Cash on Delivery":
                    identifier = "cashOnDeliveryBankingPage"
                case "Credit Card":
                    identifier = "creaditCardPage"
                default:
                    print("hello")
                
            }
            //create a variable to tell this class where the bundle is and define it.
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //setup the view controller to be presented.
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: identifier!)
            //define that we want to have the modal presentation fill the screen.
            nextViewController.modalPresentationStyle = .fullScreen
            
            //actually present the next view.
            self.present(nextViewController, animated: true, completion:nil)
            print("index \(index) and \(title)")
        }
    }
    
    /// Saves the order in relevant variables
    @IBAction func placeOrder(_ sender: Any) {
        if canPay == true{
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
        } else{
            error.text = "Error: Must choose payment option"
        }
    }
}
