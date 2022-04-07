//
//  Navigation.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/7/22.
//

import Foundation
import UIKit

class Navigation{
    
    static func goToProfileFromSwiftUI(){
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "accountPage")
    
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = rootViewController
            window.endEditing(true)
            window.makeKeyAndVisible()
        }
    }
    
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
    
    
    
    
}
