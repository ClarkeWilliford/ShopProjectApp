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
    @IBOutlet weak var wishlistButtonOutlet: UIButton!
    @IBOutlet weak var historyButtonOutlet: UIButton!
    //Label and Image Outlets
    @IBOutlet weak var userNameOutlet: UILabel!
    @IBOutlet weak var userEmailOutlet: UILabel!
    @IBOutlet weak var userImageOutlet: UIImageView!
    @IBOutlet weak var refundBalanceOutlet: UILabel!
    @IBOutlet weak var refundBalanceLabel: UILabel!
    
    //Necessary functions for Collection View
    /*This sets the number of items in this collection view. We do it based on the number of items in the userrOrderList which is a variable with all the logged in user's items in the User_Orders table in the database. */
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

               // 3 cell same size in each row space between them 4
               let spaceBetweenCell :CGFloat = 4.0  // if you change this parmters you have to change minimumInteritemSpacingForSectionAt ,
               let screenWidth = UIScreen.main.bounds.size.width - CGFloat(2 * spaceBetweenCell)
               let totalSpace = spaceBetweenCell * 2.0;  // there is 2 between  3 item
        return CGSize(width: (screenWidth - totalSpace)/3, height: (screenWidth-totalSpace)/2.5)

           }

           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
               return 4.0 // space between sections
           }

           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
               return 4.0 // space between items in row
           }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        database.OpenDatabase()
        GlobalVariables.orderItems = [Items]()
        database.orderItems = [Items]()
        database.userOrderList = [UserOrder]()
        database.fetchUserOrderItems()
        userNameOutlet.text = GlobalVariables.userLoggedIn.fname
        userEmailOutlet.text = GlobalVariables.userLoggedIn.email
        refundBalanceOutlet.text = GlobalVariables.userLoggedIn.balance
        
        //Styling the buttons and labels
        Styles.styleFilledButton(refundButtonOutlet)
        Styles.styleFilledButton(feedbackButtonOutlet)
        Styles.styleFilledButton(trackMyOrderButtonOutlet)
        Styles.styleFilledButton(wishlistButtonOutlet)
        Styles.styleFilledButton(historyButtonOutlet)
        Styles.styleLabel(refundBalanceLabel)
        
        
    }
    
    @IBAction func goToOrderTracker(_ sender: Any) {
        //setup the bundle infromation.
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //define the next controller to move to.
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "trackerPage")
        //actually present the next controller.
        self.present(nextViewController, animated: true, completion:nil)
    }
    
    @IBAction func goToRefundScreen(_ sender: Any) {
        //calls the function from Navigation.
        Navigation.goToRefund()
    }
    
    @IBAction func goToFeedbackScreen(_ sender: Any) {
        //calls the function from Navigation.
        Navigation.goToFeedback()
    }
    
    @IBAction func goToWishlistScreen(_ sender: Any) {
        //calls the function from Navigation.
        Navigation.goToWishlist()
    }
    
    @IBAction func goToHistoryScreen(_ sender: Any) {
        Navigation.goToHistory()
    }
    
}
