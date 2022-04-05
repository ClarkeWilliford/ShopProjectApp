//
//  ProceedToCheckoutTableViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

class ProceedToCheckoutTableViewCell: UITableViewCell {

    @IBOutlet weak var checkOutButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func proceedToCheckout(_ sender: Any) {
        print("proceeding to checkout")
    }
}
