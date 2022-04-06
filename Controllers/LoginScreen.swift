//
//  ContentView.swift
//  LoginAppDemo
//
//  Created by Stan Shockley on 4/4/22.
//

import SwiftUI

let storedUsername = "Stan"
let storedPassword = "asdf"

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidPass: Bool = false
    
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
                    if (self.username == storedUsername) && (self.password == storedPassword) {
                        self.authenticationDidPass = true
                        self.authenticationDidFail = false
                    }else {
                        self.authenticationDidFail = true
                        self.authenticationDidPass = false
                    }
                }) {
                LoginButtonText()
            }
        }.padding()
            if authenticationDidPass {
                Text("Login Successful!")
                    .font(.headline)
                    .frame(width: 250, height: 30)
                    .background(Color.yellow)
                    .padding(.bottom, 30)
                    .animation(Animation.default)
            }
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
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
        Image("cart1")
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
}

struct usernameTextField: View {
    
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username)
            
            .padding()
            .background(.mint)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct passwordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(.mint)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
