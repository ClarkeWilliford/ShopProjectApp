//
//  GlobalVariables.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/5/22.
//

import Foundation

class GlobalVariables {
    
    static var userLoguedIn : User = User(id: 0, name: "", email: "", password: "", phone: "")
    
    static var userTryingToLogin: User = User(id: 0, name: "", email: "", password: "", phone: "")
    
    static var itemsInCart = [Items]()
    
    static var itemsInWishlist = [Items]()

    static var chosenItem = Items(id: 0, name: "", image: "", price: "", description: "", productID: 0)
    
}
