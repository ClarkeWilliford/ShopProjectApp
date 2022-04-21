//
//  ContentView.swift
//  LoginAppDemo
//
//  Created by Stan Shockley on 4/4/22.
//

import SwiftUI
import SQLite3
import UIKit
import FirebaseAuth
import Firebase
import Foundation
import FirebaseFirestore

let storedUsername = "Stan"
let storedPassword = "asdf"
let yellow = Color(red: 255/255, green: 239/255, blue: 93/255)

var fbUserList = [firebaseUser]()


struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var emailOrPhoneNumber: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidPass: Bool = false
    
    @State var database = DBHelper()
    @State var firebase = Firestore.firestore()
    
    @State var currentUser = firebaseUser(id: 0, fname: "", lname: "", email: "", password: "", phone: "" )
    
    @ObservedObject private var viewModel = firebaseUserViewModel()
    
    var body: some View {
        
        
        ZStack{
            VStack {
                titleText()
                loginImage()
                Text("Login")
                    .frame(width: 400, height: 15, alignment: .topLeading)
                usernameTextField(username: $username)
                Text("Password")
                    .frame(width: 400, height: 15, alignment: .topLeading)
                passwordTextField(password: $password)
                if authenticationDidFail{
                    Text("Incorrect authentication information")
                        .offset(y: -10)
                        .foregroundColor(.red)
                }
                
                   
                Button(action: {
                    emailOrPhoneNumber = username
                    database.OpenDatabase()
                    
                    Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
                        if error != nil {
                            
                            Text("Incorrect Login Information")
                                .offset(y: -10)
                                .foregroundColor(.red)
                            
//                            self.errorLabel.text = error!.localizedDescription
//                            self.errorLabel.alpha = 1
                        } else {
                            
                            getDataFromFirestore(username)
                            
                            database.insertUser(fname: GlobalVariables.userLoggedIn.fname, lname: GlobalVariables.userLoggedIn.lname, email: emailOrPhoneNumber, password: password,  phone: GlobalVariables.userLoggedIn.phone, balance: "0")
                            
                            database.fetchUserByEmail(emailToFetch: emailOrPhoneNumber)
                            
                            dismiss()
                            
                        }
                    }
                }) {
                LoginButtonText()
            }
                
                Button(action: {
                    goToRegister()
                })
                {
                RegisterButtonText()
            }
                .onAppear(){
                    self.viewModel.fetchData()
                }
                
        }.padding()
            if authenticationDidPass {
                Text("Login Successful!")
                    .font(.headline)
                    .frame(width: 250, height: 30)
                    .background(yellow)
                    .padding(.bottom, 30)
                    .animation(Animation.default)
                
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
    
    
    func SetGlobalVariable(){
        GlobalVariables.userLoggedIn = User(id: GlobalVariables.userTryingToLogin.id, fname: GlobalVariables.userTryingToLogin.fname, lname: GlobalVariables.userTryingToLogin.lname, email: GlobalVariables.userTryingToLogin.email, password: GlobalVariables.userTryingToLogin.password, phone: GlobalVariables.userTryingToLogin.phone,balance: GlobalVariables.userTryingToLogin.balance)
        
    }
    
    func goToProfile(){
        Navigation.goToProfileFromSwiftUI()
        
    }

func goToRegister(){
    
    Navigation.goToRegisterFromSwiftUI()
    
}




struct titleText: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom,20)
    }
}

struct loginImage: View {
    var body: some View {
        Image("shopAppLogo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 125)
        
    }
}


struct LoginButtonText: View {
    var body: some View {
        Text("Login")
            .padding()
            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(35.0)
            .frame(width: 220, height: 60)
            .font(.headline)
    }
}

struct RegisterButtonText: View {
    var body: some View {
        Text("Register")
            .padding()
            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(35.0)
            .frame(width: 220, height: 60)
            .font(.headline)
    }
}

struct usernameTextField: View {
    
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username)
            
            .padding()
            .background(yellow)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct passwordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(yellow)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

func getDataFromFirestore(_ uname: String) {
    
    let fbUsername = uname
    
    let db = Firestore.firestore()
    
    db.collection("users").getDocuments { userDocument, error in
        if error == nil {
            
            if let userDocument = userDocument {
                
                DispatchQueue.main.async {
                    
                    let currentuser = Auth.auth().currentUser?.uid
                    
                    for user in userDocument.documents {
                        
                        let documentID = (user["uid"] as? String)!
                        
                        if currentuser ==  documentID {
                            
                            let currentFName = (user["firstname"] as? String)!
                            let currentLName = (user["lastname"] as? String)!
                            let currentEmail = (user["mail"] as? String)!
                            let currentPhone = (user["phone"] as? String)!
                            
                            GlobalVariables.userLoggedIn.fname = currentFName
                            GlobalVariables.userLoggedIn.lname = currentLName
                            GlobalVariables.userLoggedIn.email = currentEmail
                            GlobalVariables.userLoggedIn.phone = currentPhone
                        
                        }
                        
                    }
                    
                }
                
            }
            
        }
            
    }
    
}




