//
//  CategoriesCollectionViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/5/22.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with image: UIImage){
        imageView.image = image
    }
    static func nib() -> UINib{
        return UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
    }
}
