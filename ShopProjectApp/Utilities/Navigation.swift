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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "accountPage")
    
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = rootViewController
            window.endEditing(true)
            window.makeKeyAndVisible()
        }
        
            
        }
    
    
    
    
}
