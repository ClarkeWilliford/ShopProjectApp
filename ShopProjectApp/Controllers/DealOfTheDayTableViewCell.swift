//
//  DealOfTheDayTableViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/4/22.
//

import UIKit

class DealOfTheDayTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dodImage: UIImageView!
    @IBOutlet weak var dodPrice: UILabel!
    @IBOutlet weak var dodName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
