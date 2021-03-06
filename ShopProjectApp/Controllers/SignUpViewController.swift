//
//  SignUpViewController.swift
//  Firebase3 Demo
//
//  Created by Stan Shockley on 4/14/22.
//

import UIKit
import FirebaseAuth
import Firebase

/// Sign up page loaded before user can perform certain actions like submitting a payment or accessing profile page
class SignUpViewController: UIViewController {

    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    var database = DBHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.OpenDatabase()
        setUpElements()
    }
    
    
    /// Gets login credentials through firebase, validates information and then gives access
    /// - Parameter sender: button press action
    @IBAction func signUp(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            
            showError(error!)
        } else {
                
                let firstName = fName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = lName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let phone = phone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
                if err != nil {
                    
                    self.showError("Error creating user")
                
                } else {
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "phone": phone, "mail": email, "uid": result!.user.uid]) { (error) in
                    
                        if error != nil {
                        self.showError("User data could not be added to database")
                        
                        }
                    }
                    
                    self.database.insertUser(fname: firstName, lname: lastName, email: email, password: password, phone: phone, balance: "$0")
                    
                    self.database.fetchUserByEmail(emailToFetch: email)
                    
                    Navigation.goToHome()
                
                  }
                }
            }
        }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Styles.styleTextField(fName, placeHolderString: "first name")
        Styles.styleTextField(lName, placeHolderString: "last name")
        Styles.styleTextField(phone, placeHolderString: "phone number")
        Styles.styleTextField(email, placeHolderString: "email address")
        Styles.styleTextField(password, placeHolderString: "password")
        Styles.styleHollowButton(signUpButtonOutlet)
    }
    
    func validateFields() -> String? {
        if fName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        let validPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return nil
        
    }
    
    func showError(_ message : String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func transitionToAccountPage() {
        
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "accountPage") as? ProfileViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    

}
