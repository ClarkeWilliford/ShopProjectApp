//
//  WishlistViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/17/22.
//

import UIKit
import SQLite3

class WishlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var database = DBHelper()
    
    @IBOutlet weak var wishlistTitleLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.wishlistItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath) as! WishlistTableViewCell
        cell.wishlistCellImageView.image = UIImage(named: GlobalVariables.wishlistItems[indexPath.row].image)
        cell.wishlistCellNameLabel.text = GlobalVariables.wishlistItems[indexPath.row].name
        cell.wishlistCellPriceLabel.text = GlobalVariables.wishlistItems[indexPath.row].price
        cell.wishlistCellImageView.clipsToBounds = true
        cell.wishlistCellImageView.contentMode = .scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalVariables.chosenItem = (Items(id: database.wishlistItems[indexPath.row].id, name: database.wishlistItems[indexPath.row].name, image: database.wishlistItems[indexPath.row].image, price: database.wishlistItems[indexPath.row].price, description: database.wishlistItems[indexPath.row].description, productID: database.wishlistItems[indexPath.row].productID))
        GlobalVariables.userHistory.append(GlobalVariables.chosenItem)
        Navigation.goToItemDisplay()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        database.OpenDatabase()
        database.userWishlistList = [UserOrder]()
        database.wishlistItems = [Items]()
        GlobalVariables.wishlistItems = [Items]()
        database.fetchUserWishlist()

    }


}
