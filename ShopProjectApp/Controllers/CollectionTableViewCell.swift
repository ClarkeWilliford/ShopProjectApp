//
//  CollectionTableViewCell.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/4/22.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "CollectionTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }

    /// configurs the items as model structs to be loaded into collection view
    func configure(with models: [ViewController.Model]){
        self.models = models
        collectionView.reloadData()
    }
    @IBOutlet var collectionView: UICollectionView!
    var models = [ViewController.Model]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    /// Defines the items in the collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GlobalVariables.chosenItem = (Items(id: db.suggestedItems[indexPath.row].id, name: db.suggestedItems[indexPath.row].name, image: db.suggestedItems[indexPath.row].image, price: db.suggestedItems[indexPath.row].price, description: db.suggestedItems[indexPath.row].description, productID: db.suggestedItems[indexPath.row].productID))
        GlobalVariables.userHistory.append(GlobalVariables.chosenItem)
        Navigation.goToItemDisplay()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

