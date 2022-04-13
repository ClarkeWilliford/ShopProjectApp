//
//  User.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/6/22.
//

import Foundation


struct User{
    
    var id: Int
    var name: String
    var email: String
    var password: String
    var phone: String
    var balance: String
    
    init(id: Int, name: String, email: String, password: String, phone: String, balance: String){
        
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.phone = phone
        self.balance = balance
        
    }
    
}
