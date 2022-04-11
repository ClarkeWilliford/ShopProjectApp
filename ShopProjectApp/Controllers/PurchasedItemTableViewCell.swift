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
    
    /// Initializes and sets stepper value
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.value = 1
        itemQuantity.text = "1"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// Increments stepper value
    @IBAction func stepperFunction(_ sender: UIStepper) {
        itemQuantity.text = Int(sender.value).description
        print("stepper click")
    }
    
}
