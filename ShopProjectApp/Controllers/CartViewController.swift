//
//  CartViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var purchasedItems = [["magnifyingglass", "Shoe1", "$29.99"],["pencil", "Shoe2", "$150.00"],["scribble", "Shoe3", "$20.00"],["highlighter", "Shoe4", "$34.99"], ["magnifyingglass", "shoe2", "$30.00"]]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + purchasedItems.count
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
            cell.itemImage.image = UIImage(systemName: purchasedItems[indexPath.row - 1][0])
            cell.itemName.text = purchasedItems[indexPath.row - 1][1]
            cell.itemPrice.text = purchasedItems[indexPath.row - 1][2]
            var priceString = purchasedItems[indexPath.row - 1][2]
            priceString.remove(at: priceString.startIndex)
            print(cell.itemQuantity.text)
            total = total - Double(priceString)! + Double(Int(cell.itemQuantity.text!)!) * Double(priceString)!
            //total = total - Double(purchasedItems[indexPath.row - 1][2]) + Double(cell.itemQuantity) * Double(purchasedItems[indexPath.row - 1][2])
            print("inside cell at \(indexPath.row) total is \(total)")
            print(purchasedItems[indexPath.row - 1][2])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }



    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for items in 0..<purchasedItems.count{
            var priceString = purchasedItems[items][2]
            priceString.remove(at: priceString.startIndex)
            print(priceString)
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
    
    @objc func actionReceived(){
        performSegue(withIdentifier: "showPlaceOrder", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaceOrder" {
            if let nextViewController = segue.destination as? PlaceOrderViewController {
                nextViewController.initialPrice = total
            }
        }
    }

}

