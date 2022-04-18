//
//  Helpers.swift
//  CustomLaunchScreen
//
//  Created by iMac on 2/28/22.
//
import UIKit

class Styles {
    
    //yellow color RGB values 255, 239, 93, 1
    //blue color RBG values 21, 45, 253, 1

    
    //MARK: Function to style buttons to be filled in.
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 255/255, green: 239/255, blue: 93/255, alpha: 1)
        button.layer.borderColor = CGColor.init(red: 23/255, green: 45/255, blue: 253/255, alpha: 1)
        button.titleLabel?.textColor = UIColor.init(red: 23/255, green: 45/255, blue: 253/255, alpha: 1)
        button.layer.cornerRadius = 16.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.tintColor = UIColor.black
    }
    //MARK: Function to style the labels with rounded corners.
    static func styleLabel(_ label:UILabel){
        label.backgroundColor = UIColor.yellow
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5.0
        label.tintColor = UIColor.black
    }
    //MARK: styles the button to be "hollow"
    static func styleHollowButton(_ button:UIButton) {
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 0.7).cgColor
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 16.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.tintColor = UIColor.black
    }
    //MARK: styles the error label.
    static func styleErrorLabel(_ label:UILabel){
        // Hide the error label
        label.alpha = 0
        // Set background color to black
        label.backgroundColor = UIColor.white
        // Give label border rounded edges
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
    }
    
}
