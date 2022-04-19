//
//  PurchasedItemTableViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

/// Defines the cell of items that were added to the cart in the relevant table view
class PurchasedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var remove: UIButton!
    
    /// Initializes and sets stepper value
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.value = 1
        itemQuantity.text = "1"
        NotificationCenter.default.addObserver(self, selector: #selector(unhideTrash), name: Notification.Name("unhideTrash"), object:  nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideTrash), name: Notification.Name("hideTrash"), object:  nil)
    }
    
    @objc func unhideTrash(){
        remove.isHidden = false
    }
    
    @objc func hideTrash(){
        remove.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var previousValue = 0
    /// Increments stepper value
    @IBAction func stepperFunction(_ sender: UIStepper) {
        
        if Int(sender.value) > previousValue {
            itemQuantity.text = Int(sender.value).description
            NotificationCenter.default.post(name: Notification.Name("incrementTotal"), object: nil)
        } else {
            itemQuantity.text = Int(sender.value).description
            NotificationCenter.default.post(name: Notification.Name("decrementTotal"), object: nil)
        }
        previousValue = Int(sender.value)
        NotificationCenter.default.post(name: Notification.Name("updateTable"), object: nil)
    }
    
    @IBAction func remove(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("removeItem"), object: nil)
    }
    
    
}
