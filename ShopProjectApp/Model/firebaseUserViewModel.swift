//
//  firebaseUserViewModel.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/20/22.
//

import Foundation
import FirebaseFirestore

class firebaseUserViewModel: ObservableObject{
    
    @Published var users = [firebaseUser]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("users").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.users = documents.map { (queryDocumentSnapshot) -> firebaseUser in
                let data = queryDocumentSnapshot.data()
                
                let fname = data["firstname"] as? String ?? ""
                let lname = data["lastname"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                
                return firebaseUser(id: 0, fname: fname, lname: lname, email: email, password: password, phone: phone)
                
            }
            
        }
    }
    
    
}
