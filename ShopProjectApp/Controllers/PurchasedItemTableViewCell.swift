//
//  PurchasedItemTableViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

class PurchasedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func stepperFunction(_ sender: Any) {
    }
    
}
