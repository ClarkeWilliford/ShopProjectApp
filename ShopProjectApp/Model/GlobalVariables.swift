//
//  GlobalVariables.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/5/22.
//

import Foundation

class GlobalVariables {
    
    static var userLoggedIn : User = User(id: 0, fname: "", lname: "", email: "", password: "", phone: "", balance: "")
    
    static var userTryingToLogin: User = User(id: 0, fname: "", lname: "", email: "", password: "", phone: "", balance: "")
    
    static var userHistory = [Items]()
    
    static var itemsInCart = [Items]()
    
    static var orderedItems = [Items]()
    
    static var itemsInWishlist = [Items]()
    
    static var wishlistItems = [Items]()
    
    static var historyItems = [Items]()

    static var chosenItem = Items(id: 0, name: "", image: "", price: "", description: "", productID: 0)
    
    static var itemsToRefund = [Items]()
    
    static var orderItems = [Items]()
    
    static var searchBar = [String]()
    
    static var notificationItems = [String]()
    
}
