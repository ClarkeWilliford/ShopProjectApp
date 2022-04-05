//
//  CartViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var purchasedItems = [["magnifyingglass", "Shoe1", "$29.99"],["pencil", "Shoe2", "$150.00"],["scribble", "Shoe2", "$20.00"],["highlighter", "Shoe4", "$34.99"]]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasedItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProceedToCheckoutTableViewCell", for: indexPath) as! ProceedToCheckoutTableViewCell
            
            return cell
        } else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedItemTableViewCell", for: indexPath) as! PurchasedItemTableViewCell
            cell.itemImage.image = UIImage(systemName: purchasedItems[indexPath.row][0])
            cell.itemName.text = purchasedItems[indexPath.row][1]
            cell.itemPrice.text = purchasedItems[indexPath.row][2]
            cell.itemQuantity.text = "1"
            return cell
        }
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        var nib = UINib(nibName: "ProceedToCheckoutTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProceedToCheckoutTableViewCell")
        nib = UINib(nibName: "PurchasedItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PurchasedItemTableViewCell")
    }
    

}
