//
//  Navigation.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/7/22.
//

import Foundation
import UIKit
import SwiftUI

class Navigation{
    
    
    
    

    
    
    //MARK: function to move to the profile page from the Login page.
    static func goToProfileFromSwiftUI(){
        //defines the storyboard and the bundle.
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //instantiates the view controller we are moving to.
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "accountPage")
        //sets up and moves to the desired view controller.
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = rootViewController
            window.endEditing(true)
            window.makeKeyAndVisible()
        }
    }
    
    //MARK: function to go to the item display screen.
    static func goToItemDisplay(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Sets the view to move to.
        let userViewController = storyboard.instantiateViewController(withIdentifier: "itemDisplay")
        //moves us to the view
        window.rootViewController = userViewController
        window.makeKeyAndVisible()
        
    }
    
    //MARK: function to go to the profile screen.
    static func goToProfile(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Sets the view to move to.
        let ProfileViewController = storyboard.instantiateViewController(withIdentifier: "accountPage")
        //moves us to the view
        window.rootViewController = ProfileViewController
        window.makeKeyAndVisible()
    }
    
    //MARK: function to go to the refund page.
    static func goToRefund(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Sets the view to move to.
        let RefundViewController = storyboard.instantiateViewController(withIdentifier: "refundView")
        //moves us to the view
        window.rootViewController = RefundViewController
        window.makeKeyAndVisible()
    }
    
    //MARK: function to go to the feedback page.
    static func goToFeedback(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Sets the view to move to.
        let feedbackViewController = storyboard.instantiateViewController(withIdentifier: "feedbackScreen")
        //moves us to the view
        window.rootViewController = feedbackViewController
        window.makeKeyAndVisible()
        
    }
    
    //MARK: function to go to the wishlist page.
    static func goToWishlist(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Sets the view to move to.
        let wishlistViewController = storyboard.instantiateViewController(withIdentifier: "wishlistPage")
        //moves us to the view
        window.rootViewController = wishlistViewController
        window.makeKeyAndVisible()
    }

    //MARK: function to go to the wishlist page.
    static func goToHistory(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //Sets the view to move to.
        let historyViewController = storyboard.instantiateViewController(withIdentifier: "historyPage")
        //moves us to the view
        window.rootViewController = historyViewController
        window.makeKeyAndVisible()
    }

    
}
