//
//  TabBarViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/6/22.
//

import UIKit
import SwiftUI

class TabBarViewController: UIViewController {
    
    let swiftUIController = UIHostingController(rootView: LoginView())

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @objc func homeButtonAction(_sender: UIButton!){
        print("home button pressed")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homePage")
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion:nil)
    }
    @objc func accountButtonAction(_sender: UIButton!){
        print("account button pressed")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Checks to see if there is a user logged in, if they aren't logged in, take them to the login page. 
        if GlobalVariables.userLoguedIn.name == "" {
            self.present(swiftUIController, animated: true, completion: nil)
            
        }
        else{
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "accountPage")
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion:nil)
        }
    }
    @objc func cartButtonAction(_sender: UIButton!){
        print("cart button pressed")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "cartPage")
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion:nil)
    }

}
