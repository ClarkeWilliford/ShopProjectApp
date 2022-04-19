//
//  TabBarViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/6/22.
//

import UIKit
import SwiftUI
import SQLite3

/// Defines the elements in the tab bar and ability to navigate between specific view controllers
class TabBarViewController: UIViewController {
    
    var database = DBHelper()
    
    /// Loads buttons displayed in the tab bar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //open the database
        database.OpenDatabase()
        
        view.backgroundColor = .blue
        //when search button clicked, add search bar
        let homeButton = UIButton(frame: CGRect(x: 75, y: 15, width: 30, height: 20))
        homeButton.backgroundColor = .yellow
        homeButton.setImage(UIImage(systemName: "house"), for: .normal)
        homeButton.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
        self.view.addSubview(homeButton)
        
        let accountButton = UIButton(frame: CGRect(x: 175, y: 15, width: 30, height: 20))
        accountButton.backgroundColor = .yellow
        accountButton.setImage(UIImage(systemName: "person"), for: .normal)
        accountButton.addTarget(self, action: #selector(accountButtonAction), for: .touchUpInside)
        self.view.addSubview(accountButton)
        
        let cartButton = UIButton(frame: CGRect(x: 275, y: 15, width: 30, height: 20))
        cartButton.backgroundColor = .yellow
        cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(cartButtonAction), for: .touchUpInside)
        self.view.addSubview(cartButton)
    }
    
    /// Navigates to the home page upon home button clicked
    /// - Parameter _sender: button action
    @objc func homeButtonAction(_sender: UIButton!){
        //create a variable to tell this class where the bundle is and define it.
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //setup the view controller to be presented.
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homePage")
        //define that we want to have the modal presentation fill the screen.
        nextViewController.modalPresentationStyle = .fullScreen
        
        NotificationCenter.default.post(name: Notification.Name("makeSearchHidden"), object: nil)
        print("reload table view entered?")
        NotificationCenter.default.post(name: Notification.Name("reloadTableView2"), object: nil)
        
        //actually present the next view.
        self.present(nextViewController, animated: true, completion:nil)
    }
    /// Navigates to the account page upon home button clicked
    /// - Parameter _sender: button action
    @objc func accountButtonAction(_sender: UIButton!){
        //Create objects to point to the correct controllers
        let swiftUIController = UIHostingController(rootView: LoginView())
        //Checks to see if there is a user logged in, if they aren't logged in, take them to the login page, else go to Account(profile) page.
        if GlobalVariables.userLoggedIn.name == "" {
            //present the Swift UI conteroller modally, not fullscreen.
            self.present(swiftUIController, animated: true, completion: nil)
        }
        else{
            //for loop to put any wishlist items into the database.
            for items in GlobalVariables.itemsInWishlist{
                database.insertUserWishlist(userID: GlobalVariables.userLoggedIn.id, itemID: items.id)
            }
            //clears the wishlist now that it's saved in the database.
            GlobalVariables.itemsInWishlist = [Items]()
            
            //for loop to put any history items into the database.
            for items in GlobalVariables.userHistory{
                database.insertUserHistory(userID: GlobalVariables.userLoggedIn.id, itemID: items.id)
            }
            //clears the history now that it's been saved into the database.
            GlobalVariables.userHistory = [Items]()
            
            //setup the bundle infromation.
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //define the next controller to move to.
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "accountPage")
            //define that we want it displayed in fullscreen.
            nextViewController.modalPresentationStyle = .fullScreen
            //actually present the next controller.
            self.present(nextViewController, animated: true, completion:nil)
        }
        
    }
    /// Navigates to the cart page upon home button clicked
    /// - Parameter _sender: button action
    @objc func cartButtonAction(_sender: UIButton!){
        //Define the bundle and the storyboard.
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Set the viewController to move to next.
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "cartPage")
        //Set the fullscreen setting.
        nextViewController.modalPresentationStyle = .fullScreen
        //Present the next view controller.
        self.present(nextViewController, animated: true, completion:nil)
    }
}
