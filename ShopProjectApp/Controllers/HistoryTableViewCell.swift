//
//  HistoryTableViewCell.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/17/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //Outlet Block
    @IBOutlet weak var historyCellImage: UIImageView!
    @IBOutlet weak var historyCellNameLabel: UILabel!
    @IBOutlet weak var historyCellPriceLabel: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
