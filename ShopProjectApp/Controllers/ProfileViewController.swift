//
//  ProfileViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/8/22.
//

import UIKit
import SQLite3

var database = DBHelper()

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //Outlet Block
    //Button Outlets for styling
    @IBOutlet weak var refundButtonOutlet: UIButton!
    @IBOutlet weak var feedbackButtonOutlet: UIButton!
    @IBOutlet weak var trackMyOrderButtonOutlet: UIButton!
    //Label and Image Outlets
    @IBOutlet weak var userNameOutlet: UILabel!
    @IBOutlet weak var userEmailOutlet: UILabel!
    @IBOutlet weak var userImageOutlet: UIImageView!
    @IBOutlet weak var refundBalanceOutlet: UILabel!
    
    //Necessary functions for Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.reloadData()
        return database.userOrderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! profileUserOrderCollectionViewCell
        cell.clipsToBounds = true
        cell.profileUserOrderCollectionCellImage.clipsToBounds = true
        cell.profileUserOrderCollectionCellImage.contentMode = .scaleAspectFit
        cell.profileUserOrderCollectionCellImage.image = UIImage(named: GlobalVariables.orderItems[indexPath.item].image)
        cell.profileUserOrderCollectionLabel.text = GlobalVariables.orderItems[indexPath.item].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 300, height: 200)
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        database.OpenDatabase()
        GlobalVariables.orderItems = [Items]()
        database.orderItems = [Items]()
        database.userOrderList = [UserOrder]()
        database.fetchUserOrderItems()
        userNameOutlet.text = GlobalVariables.userLoggedIn.name
        userEmailOutlet.text = GlobalVariables.userLoggedIn.email
        refundBalanceOutlet.text = GlobalVariables.userLoggedIn.balance
        
    }
    
    @IBAction func goToOrderTracker(_ sender: Any) {
    }
    
    @IBAction func goToRefundScreen(_ sender: Any) {
        Navigation.goToRefund()
    }
    
    @IBAction func goToFeedbackScreen(_ sender: Any) {
    }
    
}
