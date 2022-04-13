//
//  RefundTableViewCell.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/12/22.
//

import UIKit

class RefundTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //Outlet Block
    @IBOutlet weak var refundCellPriceLabel: UILabel!
    @IBOutlet weak var refundCellNameLabel: UILabel!
    @IBOutlet weak var refundCellImage: UIImageView!
    @IBOutlet weak var refundSelectorImage: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
