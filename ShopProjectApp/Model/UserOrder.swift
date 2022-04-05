//
//  UserOrder.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/5/22.
//

import Foundation

//struct to hold the information from the user order database
struct UserOrder{
    var userID: Int
    var itemID: Int
    
    init(userID: Int, itemID: Int){
        self.userID = userID
        self.itemID = itemID
    }
    
}
