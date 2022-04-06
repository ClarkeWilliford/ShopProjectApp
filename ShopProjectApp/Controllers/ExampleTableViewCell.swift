//
//  ExampleTableViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/4/22.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIButton!
    @IBOutlet weak var itemPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func itemSelected(_ sender: Any) {
        print("item selected")
    }
    
}
