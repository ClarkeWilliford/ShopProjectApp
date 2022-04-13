//
//  RefundViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/11/22.
//

import UIKit
import SQLite3



class RefundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var database = DBHelper()
    
    var refundBalance : Float = Float(GlobalVariables.userLoggedIn.balance.filter({ "1234567890.".contains($0) }))!
    var originalString = ""
    var numberString = ""
    
    var selectorImage = RefundCellSelector(image: "circle")
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GlobalVariables.orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "refundCell", for: indexPath) as! RefundTableViewCell
        cell.refundCellImage.image = UIImage(named: GlobalVariables.orderItems[indexPath.row].image)
        cell.refundCellNameLabel.text = GlobalVariables.orderItems[indexPath.row].name
        cell.refundCellPriceLabel.text = GlobalVariables.orderItems[indexPath.row].price
        cell.refundCellImage.clipsToBounds = true
        cell.refundCellImage.contentMode = .scaleAspectFit
        cell.refundSelectorImage.image = UIImage(systemName: selectorImage.imageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell = tableView.dequeueReusableCell(withIdentifier: "refundCell", for: indexPath) as! RefundTableViewCell
        cell.refundSelectorImage.image = UIImage(systemName: "circle.fill")
        cell.refundCellImage.image = UIImage(named: GlobalVariables.orderItems[indexPath.row].image)
        cell.refundCellNameLabel.text = GlobalVariables.orderItems[indexPath.row].name
        cell.refundCellPriceLabel.text = GlobalVariables.orderItems[indexPath.row].price
        selectorImage.imageArray[indexPath.row] = "circle.fill"
        
        GlobalVariables.itemsToRefund.append(Items(id: GlobalVariables.orderItems[indexPath.row].id, name: GlobalVariables.orderItems[indexPath.row].name, image: GlobalVariables.orderItems[indexPath.row].image, price: GlobalVariables.orderItems[indexPath.row].price, description: GlobalVariables.orderItems[indexPath.row].description, productID: GlobalVariables.orderItems[indexPath.row].productID))
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        database.OpenDatabase()
        selectorImage.fillImageArray()
        
    }
    
    @IBAction func refundItemsButton(_ sender: Any) {
        
        print("refund complete")
        for items in GlobalVariables.itemsToRefund{
            originalString = items.price
            numberString = originalString.filter({ "1234567890.".contains($0) })
            refundBalance = refundBalance + Float(numberString)!
            database.deleteUserOrdersItems(userId: GlobalVariables.userLoggedIn.id, idToDelete: items.id)
        }
        GlobalVariables.itemsToRefund = [Items]()
        GlobalVariables.userLoggedIn.balance = "$\(refundBalance)"

        Navigation.goToProfile()
        
    }

}
