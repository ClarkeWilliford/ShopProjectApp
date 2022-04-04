//
//  ExampleTableViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/4/22.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var item1Name: UILabel!
    @IBOutlet weak var item2Name: UILabel!
    @IBOutlet weak var item3Name: UILabel!
    @IBOutlet weak var item4Name: UILabel!
    
    @IBOutlet weak var item1Price: UILabel!
    @IBOutlet weak var item2Price: UILabel!
    @IBOutlet weak var item3Price: UILabel!
    @IBOutlet weak var item4Price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func button1(_ sender: Any) {
        print("button1 clicked")
    }
    @IBAction func button2(_ sender: Any) {
        print("button2 clicked")
    }
    @IBAction func button3(_ sender: Any) {
        print("button3 clicked")
    }
    @IBAction func button4(_ sender: Any) {print("button4 clicked")
    }
    
}
