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
    
    //Necessary functions for Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return database.userOrderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! profileUserOrderCollectionViewCell
        cell.clipsToBounds = true
        cell.profileUserOrderCollectionCellImage.clipsToBounds = true
        cell.profileUserOrderCollectionCellImage.contentMode = .scaleAspectFit
        cell.profileUserOrderCollectionCellImage.image = UIImage(named: database.orderItems[indexPath.item].image)
        cell.profileUserOrderCollectionLabel.text = database.orderItems[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        database.OpenDatabase()
        database.fetchUserOrderItems()
        userNameOutlet.text = GlobalVariables.userLoggedIn.name
        userEmailOutlet.text = GlobalVariables.userLoggedIn.email

    }
    
    @IBAction func goToOrderTracker(_ sender: Any) {
    }
    
    @IBAction func goToRefundScreen(_ sender: Any) {
    }
    
    @IBAction func goToFeedbackScreen(_ sender: Any) {
    }
    
}
