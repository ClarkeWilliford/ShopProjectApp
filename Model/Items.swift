//
//  Items.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/4/22.
//

import Foundation
//This is a struct created to hold the information for each item we are selling.
//The information here matches up with the fields in the database.
//When the database is queried, this can store the information retrieved.
struct Items{
    //Varibalse to hold the information.
    var id: Int
    var name: String
    var image: String
    var price: String
    var description : String
    var productID: Int
    //Init block to get the information and set it.
    init(id: Int,name: String,image: String,price: String,description: String,productID: Int){
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.description = description
        self.productID = productID
    }
    
}
