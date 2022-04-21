//
//  FeedbackViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/14/22.
//

import UIKit

class FeedbackViewController: UIViewController {

    //Outlet Block
    @IBOutlet weak var feedbackSubmitButtonOutlet: UIButton!
    @IBOutlet weak var feedbackTextFieldOutlet: UITextView!
    
    //database object
    var database = DBHelper()
    
    //variable to hold the text data
    var feedbackText : String = ""
    
    //counter to change the screen to thank the user for the feedback.
    var buttonPressed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //call to open the database
        database.OpenDatabase()
        Styles.styleTextView(feedbackTextFieldOutlet, placeHolderString: "Please write your feedback here.")
        Styles.styleFilledButton(feedbackSubmitButtonOutlet)
       
    }
    

    @IBAction func feedbackSubmitButtonAction(_ sender: Any) {
        //Set the variable to hold the text entered into the text field.
        feedbackText = feedbackTextFieldOutlet.text!
        
        //if statement to check how many times they clicked the submit feedback button.
        if buttonPressed == 0{
            //calls the function to insert the feedback into the database.
            database.insertUserFeedback(userID: GlobalVariables.userLoggedIn.id, feedback: feedbackText)
            
            //sets the text box to thank the user for their feedback.
            feedbackTextFieldOutlet.text = "Thank you for the feedback!"
            feedbackSubmitButtonOutlet.setTitle("Return to Profile", for: .normal)
            buttonPressed += 1
        }
        else{
            Navigation.goToProfile()
        }
        
        
    }
    

}
