//
//  MyCollectionViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/4/22.
//

import UIKit

/// Collection view that holds image and label for suggested items
class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myLabel: UILabel!
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Pass in model struct to configure label and image view
    public func configure(with model: ViewController.Model){
        self.myLabel.text = model.text
        self.myImageView.image = UIImage(named: model.imageName)
        self.myImageView.contentMode = .scaleAspectFill
    }
}
