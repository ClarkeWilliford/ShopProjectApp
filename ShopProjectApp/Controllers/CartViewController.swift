//
//  CartViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

 /// Defines the cart view page. Hosts a collection view in the first row, an image, price and name in the second row, and the set of available items in the subsequent rows
class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// Shows all the items in the cart
    /// - Parameters:
    ///   - tableView: items in cart and proceed to check out in cells
    ///   - section: number of items in cart plus the proceed to check out cell
    /// - Returns: count of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + GlobalVariables.itemsInCart.count
    }
    
    /// Sets height for the table view cells
    /// - Parameters:
    ///   - tableView: Table view holds items in cart
    ///   - indexPath: row index
    /// - Returns: height of the table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

    
    var total = 0.0
    var sign = 0
    var count = 0
    var itemToDelete: Int?
    /// Defines the various cells in the table view
    /// - Returns: Cells that are delinated by indexPath.row, row 0 has different cells than rows > 0. Rows > 0 contained item image, name, and price. Row 0 holds a label and button to proceed to check out.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProceedToCheckoutTableViewCell", for: indexPath) as! ProceedToCheckoutTableViewCell
            if GlobalVariables.itemsInCart.isEmpty{
                cell.totalPrice.text = ("No items in cart")
            } else {
                cell.totalPrice.text = ("Total: $\(total)")
            }
            return cell
        } else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedItemTableViewCell", for: indexPath) as! PurchasedItemTableViewCell
            cell.itemImage.image = UIImage(named: GlobalVariables.itemsInCart[indexPath.row - 1].image.replacingOccurrences(of: ".jpeg", with: ""))
            cell.itemName.text = GlobalVariables.itemsInCart[indexPath.row - 1].name ?? "No items in cart"
            cell.itemPrice.text = GlobalVariables.itemsInCart[indexPath.row - 1].price ?? ""
            var priceString = GlobalVariables.itemsInCart[indexPath.row - 1].price ?? ""
            priceString.remove(at: priceString.startIndex)

            if count == 0{
                if sign == 1{
                    total = total + Double(priceString)!// + Double(Int(cell.itemQuantity.text!)!) * Double(priceString)!
                } else if sign == -1 {
                    total = total - 1 * Double(priceString)!
                }
                total = Double(round(100*total)/100)
                tableView.reloadData()
                count += 1
            }
            
            if(Int(cell.itemQuantity.text!) == 0){
                itemToDelete = indexPath.row - 1
                print(itemToDelete)
                NotificationCenter.default.post(name: Notification.Name("unhideTrash"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("hideTrash"), object: nil)
            }
            return cell
        }
    }

    @IBOutlet weak var tableView: UITableView!
    /// Sets table view datasource, delegate, and registers nib files as well as setting a notification observer for the proceed to checkout action being received.
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: Notification.Name("updateTable"), object:  nil)
        NotificationCenter.default.addObserver(self, selector: #selector(incrementTotal), name: Notification.Name("incrementTotal"), object:  nil)
        NotificationCenter.default.addObserver(self, selector: #selector(decrementTotal), name: Notification.Name("decrementTotal"), object:  nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeItem), name: Notification.Name("removeItem"), object:  nil)
    }
    
    /// Navigate to relevant view once the action under observation has been observed via the notification center
    @objc func actionReceived(){
        performSegue(withIdentifier: "showPlaceOrder", sender: nil)
    }
    
    @objc func updateTable(){
        tableView.reloadData()
    }
    
    @objc func incrementTotal(){
        sign = 1
        count = 0
    }
    
    @objc func decrementTotal(){
        sign = -1
        count = 0
    }
    
    @objc func removeItem(){
        if let item = itemToDelete{
            print(item)
            GlobalVariables.itemsInCart.remove(at: item)
            tableView.reloadData()
        } else {
            print("no item to delete")
        }
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

