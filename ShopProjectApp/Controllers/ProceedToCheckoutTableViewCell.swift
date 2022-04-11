//
//  ProceedToCheckoutTableViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

class ProceedToCheckoutTableViewCell: UITableViewCell {

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var checkOutButton: UIButton!
    var didNavigate = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func proceedToCheckout(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("procedToCheckoutAction"), object: nil)
        print(GlobalVariables.itemsInCart)
        print("clicked place order")
    }
}
