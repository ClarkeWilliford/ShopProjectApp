//
//  TabBarViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/6/22.
//

import UIKit
import SwiftUI

class TabBarViewController: UIViewController {

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
        print("account button pressed")
        //create a variable to tell this class where the bundle is and define it.
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //setup the view controller to be presented.
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homePage")
        //define that we want to have the modal presentation fill the screen.
        nextViewController.modalPresentationStyle = .fullScreen
        //actually present the next view.
        self.present(nextViewController, animated: true, completion:nil)
        
    }
    @objc func accountButtonAction(_sender: UIButton!){
        //Create objects to point to the correct controllers
        let swiftUIController = UIHostingController(rootView: LoginView())
        //Checks to see if there is a user logged in, if they aren't logged in, take them to the login page, else go to Account(profile) page.
        if GlobalVariables.userLoggedIn.name == "" {
            //present the Swift UI conteroller modally, not fullscreen.
            self.present(swiftUIController, animated: true, completion: nil)
        }
        else{
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
    @objc func cartButtonAction(_sender: UIButton!){
        print("cart button pressed")
        //Define the bundle and the storyborad.
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Set the viewController to move to next.
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "cartPage")
        //Set the fullscreen setting.
        nextViewController.modalPresentationStyle = .fullScreen
        //Present the next view controller.
        self.present(nextViewController, animated: true, completion:nil)
    }

}
