//
//  DBHelper.swift
//  ShopGroupApp
//
//  Created by Clarke Williford on 3/30/22.
//

import Foundation
import SQLite3

class DBHelper{

    var dataBase: OpaquePointer?
    
//    init(){
//        self.connect()
//    }
    
    //array of structs to hold item information
    var itemsList = [Items]()
    //array of class instance to hold information on a single item.
    var chosenItemList = [Items]()
    
    var suggestedItem = Items(id: 0, name: "", image: "", price: "", description: "", productID: 0)
    //arrays to hold the suggested items.
    var suggestedList = [Suggested]()
    var suggestedItems = [Items]()
    
    //arrays to hold the users order items
    var userOrderList = [UserOrder]()
    var orderItems = [Items]()
    
    //arrays to hold the user wishlist items
    var userWishlistList = [UserOrder]()
    var wishlistItems = [Items]()
    
    //arrays to hold the user history items
    var userHistoryList = [UserOrder]()
    var historyItems = [Items]()

    //MARK: Data base preparation
    func prepareDatabaseFile() -> String {
    
        //Name of the database
        let fileName: String = "ShopGroupAppDB.db"

        //This is the path of the data base
        let fileManager:FileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentUrl = directory.appendingPathComponent(fileName)
        let bundleUrl = Bundle.main.resourceURL?.appendingPathComponent(fileName)

        // check if file already exists on simulator
        if fileManager.fileExists(atPath: (documentUrl.path)) {
        // print("document file exists!")
        return documentUrl.path
        }
        else if fileManager.fileExists(atPath: (bundleUrl?.path)!) {
            print("document file does not exist, copy from bundle!")
            try! fileManager.copyItem(at:bundleUrl!, to:documentUrl)
        }
        //return the path to the databse.
        return documentUrl.path
    }

    //MARK: Function to open the database.
    func OpenDatabase() {
        //calls the function to find or create the database, stores the path in f1
        let f1 = prepareDatabaseFile()
        //prints the database to the console so we can find it, if needed.
        print("Data base phat is :", f1)
        //Open the Data base or create it
        if sqlite3_open(f1, &dataBase) != SQLITE_OK{
            print("Can not open data base")
        
            }
        }
    
    
    //MARK: Function to Pull all products.
    func FetchItems() {
        //Holds the query.
        let query = "select * from items"
        //Holds the pointer.
        var stmt : OpaquePointer?
        //Queries the database and prints any error.

//        if sqlite3_prepare_v2(db, query, -2, &stmt, nil) != SQLITE_OK{
   //         let err = String(cString: sqlite3_errmsg(db)!)
        if sqlite3_prepare(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
            return
        }
        //While loop to add information to the array.
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //variables to hold the information retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt,1))
            let image = String(cString: sqlite3_column_text(stmt, 2))
            let price = String(cString: sqlite3_column_text(stmt, 3))
            let description = String(cString: sqlite3_column_text(stmt, 4))
            let productID = sqlite3_column_int(stmt, 5)
            //Appends the information to the array.
            itemsList.append(Items(id: Int(id), name: name, image: image, price: price, description: description, productID: Int(productID)))
        }
        
    }
    
    //MARK: Function to pull product with specific ID.
    func FetchItemByID(idToFetch: Int){
        //Holds the id to use.
        let idToUse = idToFetch
        //Holds the query.
        let query = "select * from items where ID = '\(idToUse)'"
        //Holds the pointer.
        var stmt : OpaquePointer?
        //Queries the database and prints any error.
        if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
            return
        }
        
        //While loop to add information to the array.
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //variables to hold the information retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt,1))
            let image = String(cString: sqlite3_column_text(stmt, 2))
            let price = String(cString: sqlite3_column_text(stmt, 3))
            let description = String(cString: sqlite3_column_text(stmt, 4))
            let productID = sqlite3_column_int(stmt, 5)
            //Appends the information to the array.
            chosenItemList.removeAll()
            chosenItemList.append(Items(id: Int(id), name: name, image: image, price: price, description: description, productID: Int(productID)))
            }
        
            for list in chosenItemList{
                GlobalVariables.chosenItem = Items(id: list.id, name: list.name, image: list.image, price: list.price, description: list.description, productID: list.productID)
            }
    }
    
    //MARK: Function to pull product with specific name.
    func FetchItemByName(nameToFetch: String){
        print("inside fetch by name")
        //Holds the id to use.
        let nametoUse = nameToFetch.replacingOccurrences(of: "'s", with: "''s")
        //Holds the query.
        let query = "select * from Items where Name = '\(nametoUse)'"
        //Holds the pointer.
        var stmt : OpaquePointer?
        //Queries the database and prints any error.
        if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
            return
        }
        
        //While loop to add information to the array.
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //variables to hold the information retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt,1))
            let image = String(cString: sqlite3_column_text(stmt, 2))
            let price = String(cString: sqlite3_column_text(stmt, 3))
            let description = String(cString: sqlite3_column_text(stmt, 4))
            let productID = sqlite3_column_int(stmt, 5)
            //Appends the information to the array.
            chosenItemList.removeAll()
            chosenItemList.append(Items(id: Int(id), name: name, image: image, price: price, description: description, productID: Int(productID)))
            }
        
            for list in chosenItemList{
                GlobalVariables.chosenItem = Items(id: list.id, name: list.name, image: list.image, price: list.price, description: list.description, productID: list.productID)
            }
    }
    
    //MARK: function to fetch the suggested items from the Database by their Item ID.
    func FetchSuggestedItemByID(idToFetch: Int){
        //Holds the id to use.
        let idToUse = idToFetch
        //Holds the query.
        let query = "select * from items where ID = '\(idToUse)'"
        //Holds the pointer.
        var stmt : OpaquePointer?
        //Queries the database and prints any error.
        if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
            return
        }
        
        //While loop to add information to the array.
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //variables to hold the information retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt,1))
            let image = String(cString: sqlite3_column_text(stmt, 2))
            let price = String(cString: sqlite3_column_text(stmt, 3))
            let description = String(cString: sqlite3_column_text(stmt, 4))
            let productID = sqlite3_column_int(stmt, 5)
            //Appends the information to the array.
            chosenItemList.removeAll()
            chosenItemList.append(Items(id: Int(id), name: name, image: image, price: price, description: description, productID: Int(productID)))
        }
        
            for list in chosenItemList{
                suggestedItem = Items(id: list.id, name: list.name, image: list.image, price: list.price, description: list.description, productID: list.productID)
        }
    }
    
    //MARK: function to pull the suggested items and store them.
    func fetchSuggestedItems(){
        
            //Holds the query.
            let query = "select * from Suggested_Items"
            //Holds the pointer.
            var stmt : OpaquePointer?
            //Queries the database and prints any error.
            if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
                return
            }
            
            //While loop to add information to the array.
            while(sqlite3_step(stmt) == SQLITE_ROW){
                //variables to hold the information retrieved.
                let id = sqlite3_column_int(stmt, 0)
                let itemID = sqlite3_column_int(stmt,1)
                //Appends the information to the array.
                suggestedList.append(Suggested(id: Int(id), itemID: Int(itemID)))
            }
                //For loop fetches the item by the ID, appends the struct object to the array using chosenItem (set in the fetch call) and then clears chosenItem for the next iteration of the loop. At the end, suggested Items should be full of the items suggested, and chosenItem should be empty.
                for list in suggestedList{
                    FetchSuggestedItemByID(idToFetch: list.itemID)
                    suggestedItems.append(Items(id: suggestedItem.id, name: suggestedItem.name, image: suggestedItem.image, price: suggestedItem.price, description: suggestedItem.description, productID: suggestedItem.productID))
                                          
                //should be able to use the "Suggested Items" array to set the information for the suggested items in any of our collection views.
                }
            }
    
    //MARK: function to add the users ordered items into the database.
    func insertUserOrders(userID: Int, itemID: Int){
        

            //Variables to hold the information for the User
            let userID = Int32(userID)
            let itemID = Int32(itemID)
            

            var stmt: OpaquePointer?
           // stores the query for the database.
            let query = "INSERT INTO User_Orders (UserID,ItemID) VALUES (?,?)"
           
            //Sends the query to the database.
            if sqlite3_prepare_v2(dataBase, query, -1, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //binds the userID
            if sqlite3_bind_int(stmt, 1, userID) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //binds the itemID
            if sqlite3_bind_int(stmt, 2, itemID) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }

            //Checks if the bindings succeeded.
            if sqlite3_step(stmt) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //Prints to the console.
            print("data save")
        }
    
    
    //MARK: function to add the users into the database.
    func insertUser(fname: String, lname: String, email: String, password: String, phone: String, balance: String){
        
        // variables to hold the data as NString.
        let fname = fname as NSString
        let lname = lname as NSString
        let email = email as NSString
        let password = password as NSString
        let phone = phone as NSString
        let balance = balance as NSString
            
        
            

            var stmt: OpaquePointer?
           // stores the query for the database.
            let query = "INSERT INTO User (fname,email,password,phone,balance,lname) SELECT (?,?,?,?,?,?) WHERE NOT EXISTS (SELECT * FROM User WHERE fname = '\(fname)', email = '\(email)', password = '\(password)', phone = '\(phone)', lname = '\(lname)'"
           
            //Sends the query to the database.
            if sqlite3_prepare_v2(dataBase, query, -1, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //binds the fname
        if sqlite3_bind_text(stmt, 1, fname.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
        
            //binds the email
        if sqlite3_bind_text(stmt, 2, email.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
        
            //binds the password
        if sqlite3_bind_text(stmt, 3, password.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
        
            //binds the phone
        if sqlite3_bind_text(stmt, 4, phone.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
        
            //binds the balance
        if sqlite3_bind_text(stmt, 5, balance.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
        
            //binds the lname
        if sqlite3_bind_text(stmt, 6, lname.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
        
            //Checks if the bindings succeeded.
            if sqlite3_step(stmt) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //Prints to the console.
            print("user added")
        }
    
    //MARK: Function to add the users wishlist into the database.
    func insertUserWishlist(userID: Int, itemID: Int){
        

            //Variables to hold the information for the User
            let userID = Int32(userID)
            let itemID = Int32(itemID)
            

            var stmt: OpaquePointer?
           // stores the query for the database
            let query = "INSERT INTO User_Wishlist (UserID,ItemID) VALUES (?,?)"
           
            //Sends the query to the database.
            if sqlite3_prepare_v2(dataBase, query, -1, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //binds the userID
            if sqlite3_bind_int(stmt, 1, userID) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //binds the itemID
            if sqlite3_bind_int(stmt, 2, itemID) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }

            //Checks if the bindings succeeded.
            if sqlite3_step(stmt) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //Prints to the console.
            print("data save")
        }
    
    //MARK: Function to add the users history into the database.
    func insertUserHistory(userID: Int, itemID: Int){
        

            //Variables to hold the information for the User
            let userID = Int32(userID)
            let itemID = Int32(itemID)
            

            var stmt: OpaquePointer?
           // stores the query for the database
            let query = "INSERT INTO User_History (UserID,ItemID) VALUES (?,?)"
           
            //Sends the query to the database.
            if sqlite3_prepare_v2(dataBase, query, -1, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //binds the userID
            if sqlite3_bind_int(stmt, 1, userID) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //binds the itemID
            if sqlite3_bind_int(stmt, 2, itemID) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }

            //Checks if the bindings succeeded.
            if sqlite3_step(stmt) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
            }
            //Prints to the console.
            print("data save")
        }
    
    
    
    
    //MARK: function to fetch the items a user has ordered.
    func fetchUserOrderItems(){
        
            //Id to use is pulled from the global variable
            let id = GlobalVariables.userLoggedIn.id
            //Holds the query.
            let query = "SELECT * from User_Orders where UserID = \(id)"
            //Holds the pointer.
            var stmt : OpaquePointer?
            //Queries the database and prints any error.
            if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dataBase)!)
                print(err)
                return
            }
            
            //While loop to add information to the array.
            while(sqlite3_step(stmt) == SQLITE_ROW){
                //variables to hold the information retrieved.
                let id = sqlite3_column_int(stmt, 0)
                let userID = sqlite3_column_int(stmt, 1)
                let itemID = sqlite3_column_int(stmt,2)
                //Appends the information to the array.
                userOrderList.append(UserOrder(id: Int(id), userID: Int(userID), itemID: Int(itemID)))
            }
                //For loop fetches the item by the ID, appends the struct object to the array using chosenItem (set in the fetch call) and then clears chosenItem for the next iteration of the loop. At the end, suggested Items should be full of the items suggested, and chosenItem should be empty.
                for list in userOrderList{
                    FetchItemByID(idToFetch: list.itemID)
                    orderItems.append(Items(id: GlobalVariables.chosenItem.id, name: GlobalVariables.chosenItem.name, image: GlobalVariables.chosenItem.image, price: GlobalVariables.chosenItem.price, description: GlobalVariables.chosenItem.description, productID: GlobalVariables.chosenItem.productID))
                                          
                }
                GlobalVariables.orderItems = orderItems
            }
    
    //MARK: a function to get the user inforation from the database and store it in the global variable.
    func fetchUserByEmail(emailToFetch: String){
        //Holds the id to use.
        let emailToUse = emailToFetch
        //Holds the query.
        let query = "select * from User where Email = '\(emailToUse)'"
        //Holds the pointer.
        var stmt : OpaquePointer?
        //Queries the database and prints any error.
        if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
            return
        }
        
        //While loop to add information to the array.
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //variables to hold the information retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let fname = String(cString: sqlite3_column_text(stmt,1))
            let email = String(cString: sqlite3_column_text(stmt, 2))
            let password = String(cString: sqlite3_column_text(stmt, 3))
            let phone = String(cString: sqlite3_column_text(stmt, 4))
            let balance = String(cString: sqlite3_column_text(stmt, 5))
            let lname = String(cString: sqlite3_column_text(stmt, 6))
            
            //Adds the user to the global variable.
            GlobalVariables.userLoggedIn = User(id: Int(id), fname: fname, lname: lname, email: email, password: password, phone: phone, balance: balance)
            
           
        }
        
    }
    
    //MARK: function to fetch user information based on their phone and set the global variable. 
    func fetchUserByPhone(phoneToFetch: String){
        //Holds the id to use.
        let phoneToUse = phoneToFetch
        //Holds the query.
        let query = "select * from User where Phone = '\(phoneToUse)'"
        //Holds the pointer.
        var stmt : OpaquePointer?
        //Queries the database and prints any error.
        if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
            return
        }
        
        //While loop to add information to the array.
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //variables to hold the information retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let fname = String(cString: sqlite3_column_text(stmt,1))
            let email = String(cString: sqlite3_column_text(stmt, 2))
            let password = String(cString: sqlite3_column_text(stmt, 3))
            let phone = String(cString: sqlite3_column_text(stmt, 4))
            let balance = String(cString: sqlite3_column_text(stmt, 5))
            let lname = String(cString: sqlite3_column_text(stmt, 6))
            
            //Adds the user to the global variable.
            GlobalVariables.userLoggedIn = User(id: Int(id), fname: fname, lname: lname, email: email, password: password, phone: phone, balance: balance)
            
        
        }
    }
    
    //MARK: function to remove items from the User_Orders table.
    func deleteUserOrdersItems(userId: Int, idToDelete: Int){
        //variable to hold the datbase query.
        let query = "DELETE FROM User_Orders WHERE UserID = \(userId) AND ItemID = \(idToDelete)"
        //variable to hold the opaquepointer object.
        var stmt : OpaquePointer? = nil
        //Queries datbase and prints any errors.
        if sqlite3_prepare_v2(dataBase, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("Data deleted successfully")
            }else{
                print("Data not deleted")
            }
        }
        
    }
    
    //MARK: function to add the refund balance to the user so it stays with them each time.
    func updateUserBalance(userID: Int, balance: String){
        //variable to hold our database query
        let query = "UPDATE User SET Balance = '\(balance)' WHERE ID = \(userID)"
        //variable for the opaquepointer object.
        var stmt : OpaquePointer?
        //Query the datbase
        if sqlite3_prepare_v2(dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase))
            print(err)
        }else if sqlite3_prepare_v2(dataBase, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("balance updated")
            }else{
                print("balance not updated")
            }
    
        }else{
            print("Update statement not prepared")
        }
        sqlite3_finalize(stmt)
    }
    
    //MARK: function to add the feedback to the User_Feedback table in the database.
    func insertUserFeedback(userID: Int, feedback: String){
        //Holds the data proviced to the function.
        let feed = feedback as NSString
        let id = userID

        //Holds the pointer for the database.
        var stmt: OpaquePointer?
        //Holds the Query for the database.
        let query = "INSERT INTO User_Feedback (UserID,Feedback) VALUES (?,?)"
       //Sends teh query to the database.

        if sqlite3_prepare_v2(dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
        }
        //binds the user ID, prints an error if the database throws an error message.
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
        }
        //binds the Feedback, prints an error if the database throws an error message.
        if sqlite3_bind_text(stmt, 2, feed.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
        }
        //Check if the action succeeded.
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(dataBase)!)
            print(err)
        }
        //prints to console.
        print("Feedback added to database")
        
    }
    
    //MARK: a function to grab the wishlist information from the database
    func fetchUserWishlist(){
    //Id to use is pulled from the global variable
    let id = GlobalVariables.userLoggedIn.id
    //Holds the query.
    let query = "select * from User_Wishlist where UserID = \(id)"
    //Holds the pointer.
    var stmt : OpaquePointer?
    //Queries the database and prints any error.
    if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
        let err = String(cString: sqlite3_errmsg(dataBase)!)
        print(err)
        return
    }
    
    //While loop to add information to the array.
    while(sqlite3_step(stmt) == SQLITE_ROW){
        //variables to hold the information retrieved.
        let id = sqlite3_column_int(stmt, 0)
        let userID = sqlite3_column_int(stmt, 1)
        let itemID = sqlite3_column_int(stmt,2)
        //Appends the information to the array.
        userWishlistList.append(UserOrder(id: Int(id), userID: Int(userID), itemID: Int(itemID)))
    }
        //For loop fetches the item by the ID, appends the struct object to the array using chosenItem (set in the fetch call) and then clears chosenItem for the next iteration of the loop. At the end, suggested Items should be full of the items suggested, and chosenItem should be empty.
        for list in userWishlistList{
            FetchItemByID(idToFetch: list.itemID)
            wishlistItems.append(Items(id: GlobalVariables.chosenItem.id, name: GlobalVariables.chosenItem.name, image: GlobalVariables.chosenItem.image, price: GlobalVariables.chosenItem.price, description: GlobalVariables.chosenItem.description, productID: GlobalVariables.chosenItem.productID))
                                  
        }
        GlobalVariables.wishlistItems = wishlistItems
    }
    
    //MARK: a function to grab the history information from the database
    func fetchUserHistory(){
    //Id to use is pulled from the global variable
    let id = GlobalVariables.userLoggedIn.id
    //Holds the query.
    let query = "select * from User_History where UserID = \(id)"
    //Holds the pointer.
    var stmt : OpaquePointer?
    //Queries the database and prints any error.
    if sqlite3_prepare_v2(dataBase, query, -2, &stmt, nil) != SQLITE_OK{
        let err = String(cString: sqlite3_errmsg(dataBase)!)
        print(err)
        return
    }
    
    //While loop to add information to the array.
    while(sqlite3_step(stmt) == SQLITE_ROW){
        //variables to hold the information retrieved.
        let id = sqlite3_column_int(stmt, 0)
        let userID = sqlite3_column_int(stmt, 1)
        let itemID = sqlite3_column_int(stmt,2)
        //Appends the information to the array.
        userHistoryList.append(UserOrder(id: Int(id), userID: Int(userID), itemID: Int(itemID)))
    }
        //For loop fetches the item by the ID, appends the struct object to the array using chosenItem (set in the fetch call) and then clears chosenItem for the next iteration of the loop. At the end, suggested Items should be full of the items suggested, and chosenItem should be empty.
        for list in userHistoryList{
            FetchItemByID(idToFetch: list.itemID)
            historyItems.append(Items(id: GlobalVariables.chosenItem.id, name: GlobalVariables.chosenItem.name, image: GlobalVariables.chosenItem.image, price: GlobalVariables.chosenItem.price, description: GlobalVariables.chosenItem.description, productID: GlobalVariables.chosenItem.productID))
                                  
        }
        GlobalVariables.historyItems = historyItems
    }
    
}
