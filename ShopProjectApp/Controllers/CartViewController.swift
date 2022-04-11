//
//  CartViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

/**
    Defines the cart view page. Hosts a collection view in the first row, an image, price and name in the second row, and the set of available items in the subsequent rows
 */
class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + GlobalVariables.itemsInCart.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

    
    var total = 0.0
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProceedToCheckoutTableViewCell", for: indexPath) as! ProceedToCheckoutTableViewCell
            cell.totalPrice.text = String(total)
            return cell
        } else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedItemTableViewCell", for: indexPath) as! PurchasedItemTableViewCell
            print(GlobalVariables.itemsInCart[indexPath.row - 1].image.replacingOccurrences(of: ".jpeg", with: ""))
            cell.itemImage.image = UIImage(named: GlobalVariables.itemsInCart[indexPath.row - 1].image.replacingOccurrences(of: ".jpeg", with: ""))
            cell.itemName.text = GlobalVariables.itemsInCart[indexPath.row - 1].name ?? "No items in cart"
            cell.itemPrice.text = GlobalVariables.itemsInCart[indexPath.row - 1].price ?? ""
            var priceString = GlobalVariables.itemsInCart[indexPath.row - 1].price ?? ""
            priceString.remove(at: priceString.startIndex)
            total = total - Double(priceString)! + Double(Int(cell.itemQuantity.text!)!) * Double(priceString)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }



    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for items in 0..<GlobalVariables.itemsInCart.count{
            var priceString = GlobalVariables.itemsInCart[items].price
            priceString.remove(at: priceString.startIndex)
            total += Double(priceString)!
        }
        tableView.delegate = self
        tableView.dataSource = self
        var nib = UINib(nibName: "ProceedToCheckoutTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProceedToCheckoutTableViewCell")
        nib = UINib(nibName: "PurchasedItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PurchasedItemTableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(actionReceived), name: Notification.Name("procedToCheckoutAction"), object:  nil)
    }
    
    /// Navigate to relevant view once the action under observation has been observed via the notification center
    @objc func actionReceived(){
        performSegue(withIdentifier: "showPlaceOrder", sender: nil)
    }
    
    /// Prepares to transfer data from this view to the next when the segue is performed from actionReceiveed()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaceOrder" {
            if let nextViewController = segue.destination as? PlaceOrderViewController {
                nextViewController.initialPrice = total
            }
        }
    }
}

