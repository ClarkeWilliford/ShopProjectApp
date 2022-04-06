//
//  CartViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var purchasedItems = [["magnifyingglass", "Shoe1", "$29.99"],["pencil", "Shoe2", "$150.00"],["scribble", "Shoe3", "$20.00"],["highlighter", "Shoe4", "$34.99"]]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + purchasedItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20.0
//    }
    
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
//            cell.itemQuantity.text = "2"
//            var intItemQuantity = Int(cell.itemQuantity.text!)!
//            var priceString = purchasedItems[indexPath.row - 1][2]
//            priceString.remove(at: priceString.startIndex)
//            var doubleItemPrice = Double(priceString)!
//            total = total + doubleItemPrice*Double(intItemQuantity) - doubleItemPrice
//            print(total)
            return cell
        }
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
    }
    

}

