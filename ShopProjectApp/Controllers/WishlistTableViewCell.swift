//
//  WishlistTableViewCell.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/17/22.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var wishlistCellImageView: UIImageView!
    @IBOutlet weak var wishlistCellNameLabel: UILabel!
    @IBOutlet weak var wishlistCellPriceLabel: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
