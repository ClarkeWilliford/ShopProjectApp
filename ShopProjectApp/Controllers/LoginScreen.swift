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

let storedUsername = "Stan"
let storedPassword = "asdf"
let yellow = Color(red: 255/255, green: 239/255, blue: 93/255)




struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var emailOrPhoneNumber: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidPass: Bool = false
    
    @State var database = DBHelper()
    
    
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
                    if Validate.isValidEmail(email: emailOrPhoneNumber){
                    database.fetchUserByEmail(emailToFetch: emailOrPhoneNumber)
                    }
                    else{
                        database.fetchUserByPhone(phoneToFetch: emailOrPhoneNumber)
                    }
                    
                    if (self.emailOrPhoneNumber == GlobalVariables.userTryingToLogin.email || self.emailOrPhoneNumber == GlobalVariables.userTryingToLogin.phone) && (self.password == GlobalVariables.userTryingToLogin.password) {
                        self.authenticationDidPass = true
                        self.authenticationDidFail = false
                        SetGlobalVariable()
                        dismiss()
                        
                        }else {
                        self.authenticationDidFail = true
                        self.authenticationDidPass = false
                    }
                    
                    Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
                        if error != nil {
                            
                            Text("Incorrect Login Information")
                                .offset(y: -10)
                                .foregroundColor(.red)
                            
//                            self.errorLabel.text = error!.localizedDescription
//                            self.errorLabel.alpha = 1
                        } else {
                            
                            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                            let window = sceneDelegate!.window
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "accountPage")
                            nextViewController.modalPresentationStyle = .fullScreen
                            window!.rootViewController = nextViewController
                            window!.makeKeyAndVisible() }
                    }
                }) {
                LoginButtonText()
            }
                
                Button(action: {
                    
                    goToRegister()

                    
                    //                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    //instantiates the view controller we are moving to.
//                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
//                    //sets up and moves to the desired view controller.
//                    if let window = UIApplication.shared.windows.first{
//                        window.rootViewController = rootViewController
//                        window.endEditing(true)
//                        window.makeKeyAndVisible()
//                    }
                    
                    //if (self.username == storedUsername) && (self.password == storedPassword) {
//                        self.authenticationDidPass = true
//                        self.authenticationDidFail = false
//                    }else {
//                        self.authenticationDidFail = true
//                        self.authenticationDidPass = false
//
//                    }
//                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
//                          let window = sceneDelegate.window else { return }
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterVC")
//                    nextViewController.modalPresentationStyle = .fullScreen
//
////                    if let window = UIApplication.shared.windows.first{
////                        window.rootViewController = nextViewController
////                        window.endEditing(true)
////                        window.makeKeyAndVisible()
//                   // }
//                    window.rootViewController = nextViewController
//                    window.makeKeyAndVisible()
                })
                {
                RegisterButtonText()
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
