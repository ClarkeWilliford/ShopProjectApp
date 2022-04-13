//
//  refundCellSelector.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/13/22.
//

import Foundation


struct RefundCellSelector{
    
    var image: String
    var imageArray: [String] = []
    
    init(image: String){
        
        self.image = image
    }
    
    mutating func fillImageArray(){
        
        for items in GlobalVariables.orderItems{
            imageArray.append(image)
        }
        
    }
    
    
}


