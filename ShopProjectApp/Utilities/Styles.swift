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

    static func styleTextView(_ textfield:UITextView, placeHolderString:String) {
        
        // disable auto capitalize first letter
        textfield.autocapitalizationType = .none
        
        // Create the bottom line
        let bottomLine = CALayer()
        // Define the configuration of the bottomLine
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 7, width: textfield.frame.width, height: 8)
        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 239/255, blue: 93/255, alpha: 1).cgColor
        
        //Sets attributes in the Text Field
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 30)
        ]
        //Sets the placeholder string for the atrributes.
        textfield.attributedText = NSAttributedString(string: placeHolderString, attributes: attributes)
        
        // Remove border on text field
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor.init(red: 255/255, green: 239/255, blue: 93/255, alpha: 0.7).cgColor
        textfield.layer.cornerRadius = 10.0
        textfield.backgroundColor =  UIColor.white
        
        //white.withAlphaComponent(CGFloat(0.75))
        textfield.font = UIFont(name: "Bold", size: 45)
        textfield.textColor = UIColor.black
        
        // set the cursor color
        textfield.tintColor = UIColor.systemCyan
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleTextField(_ textfield:UITextField, placeHolderString:String) {
        
        // disable auto capitalize first letter
        textfield.autocapitalizationType = .none
        
        // Create the bottom line
        let bottomLine = CALayer()
        // Define the configuration of the bottomLine
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 7, width: textfield.frame.width, height: 8)
        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 239/255, blue: 93/255, alpha: 1).cgColor
        
        //Sets attributes in the Text Field
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 30)
        ]
        //Sets the placeholder string for the atrributes.
        textfield.attributedPlaceholder = NSAttributedString(string: placeHolderString, attributes: attributes)
        
        // Remove border on text field
        textfield.borderStyle = .none
        textfield.layer.cornerRadius = 10.0
        textfield.backgroundColor =  UIColor.white
        
        //white.withAlphaComponent(CGFloat(0.75))
        textfield.font = UIFont(name: "Bold", size: 45)
        textfield.textColor = UIColor.black
        
        // set the cursor color
        textfield.tintColor = UIColor.systemCyan
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    
    //MARK: Function to style buttons to be filled in.
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 255/255, green: 239/255, blue: 93/255, alpha: 1)
        button.layer.borderColor = CGColor.init(red: 23/255, green: 45/255, blue: 253/255, alpha: 1)
        button.titleLabel?.textColor = UIColor.init(red: 25/255, green: 45/255, blue: 253/255, alpha: 1)
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
        button.layer.borderColor = UIColor.init(red: 21/255, green: 45/255, blue: 253/255, alpha: 0.7).cgColor
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 16.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.tintColor = UIColor.black
        button.clipsToBounds = true
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
