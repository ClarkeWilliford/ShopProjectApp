//
//  UserOrder.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/5/22.
//

import Foundation

//struct to hold the information from the user order database
struct UserOrder{
    var id: Int
    var userID: Int
    var itemID: Int
    
    init(id: Int, userID: Int, itemID: Int){
        self.id = id
        self.userID = userID
        self.itemID = itemID
    }
    
}
