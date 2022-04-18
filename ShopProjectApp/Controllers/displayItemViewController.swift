//
//  displayItemViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/5/22.
//

import UIKit
import SQLite3

class displayItemViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    

    
    //Outlet Block
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var NameLabelOutlet: UILabel!
    @IBOutlet weak var PriceLabelOutlet: UILabel!
    @IBOutlet weak var DescriptionLabelOutlet: UILabel!
    @IBOutlet weak var AddToCartOutlet: UIButton!
    @IBOutlet weak var AddToWishlistOutlet: UIButton!
    
    //variables needed by the view.
    var dataBase = DBHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside display item")
        //Sets up an opens the database.
        dataBase.OpenDatabase()
        //Fetches the suggested items.
        dataBase.fetchSuggestedItems()
        //Fetches the first item in the Items table as a placeholder.
        
        //Sets the UIElements to whatever the chosen item is.
        imageViewOutlet.image = UIImage(named: GlobalVariables.chosenItem.image)
        NameLabelOutlet.text = GlobalVariables.chosenItem.name
        PriceLabelOutlet.text = GlobalVariables.chosenItem.price
        DescriptionLabelOutlet.text = GlobalVariables.chosenItem.description
        
    }
    
    //Function to control the number of sections in the collection view.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataBase.suggestedList.count
    }
    //Function to setup the individual cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestedCell", for: indexPath) as! SuggestedItemCollectionViewCell
        cell.clipsToBounds = true
        cell.contentMode = .scaleAspectFit
        cell.suggestedItemImageView.image = UIImage(named: dataBase.suggestedItems[indexPath.row].image)
        cell.suggestedItemNameLabel.text = dataBase.suggestedItems[indexPath.row].name
        cell.suggestedItemPriceLabel.text = dataBase.suggestedItems[indexPath.row].price
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: 250)
    }
    
    /// When cell in collection view is clicked, navigates to display item page with relevant chosen item data
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GlobalVariables.chosenItem = (Items(id: db.suggestedItems[indexPath.row].id, name: db.suggestedItems[indexPath.row].name, image: db.suggestedItems[indexPath.row].image, price: db.suggestedItems[indexPath.row].price, description: db.suggestedItems[indexPath.row].description, productID: db.suggestedItems[indexPath.row].productID))
        Navigation.goToItemDisplay()
    }
    
    /// Adds selected chosen item to cart
    @IBAction func addToCartAction(_ sender: UIButton) {
        print("added to cart")
        GlobalVariables.itemsInCart.append(Items(id: GlobalVariables.chosenItem.id, name: GlobalVariables.chosenItem.name, image: GlobalVariables.chosenItem.image, price: GlobalVariables.chosenItem.price, description: GlobalVariables.chosenItem.description, productID: GlobalVariables.chosenItem.productID))
        print(GlobalVariables.itemsInCart)
    }
    
    /// Adds selected chosen item to wish list
    @IBAction func addToWishlistAction(_ sender: UIButton) {
        GlobalVariables.itemsInWishlist.append(Items(id: GlobalVariables.chosenItem.id, name: GlobalVariables.chosenItem.name, image: GlobalVariables.chosenItem.image, price: GlobalVariables.chosenItem.price, description: GlobalVariables.chosenItem.description, productID: GlobalVariables.chosenItem.productID))
        
    }
}
