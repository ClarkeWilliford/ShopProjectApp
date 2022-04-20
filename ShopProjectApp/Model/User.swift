//
//  User.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/6/22.
//

import Foundation


struct User{
    
    var id: Int
    var fname: String
    var lname: String
    var email: String
    var password: String
    var phone: String
    var balance: String
    
    init(id: Int, fname: String, lname: String, email: String, password: String, phone: String, balance: String){
        
        self.id = id
        self.fname = fname
        self.lname = lname
        self.email = email
        self.password = password
        self.phone = phone
        self.balance = balance
        
    }
    
}
