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
    var chosenItem = Items(id: 0, name: "", image: "", price: "", description: "", productID: 0)
    //arrays to hold the suggested items.
    var suggestedList = [Suggested]()
    var suggestedItems = [Items]()
    
    //arrays to hold the users order items
    var userOrderList = [UserOrder]()
    var orderItems = [Items]()

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
    
//    func connect(){
//
//        // Create Items table
//        if sqlite3_exec(db, "create table if not exists Items (ID integer primary key autoincrement, Name text, Image text, Price text, Description text, ProductID integer, rightAnswer text, foreign key (ProductID) references Products (ID))", nil, nil, nil) != SQLITE_OK
//        {
//            let err = String(cString: sqlite3_errmsg(db)!)
//            print("error at create Items table --> ", err)
//        }
//
//        // Create products table
//        if sqlite3_exec(db, "create table if not exists Products (ID integer primary key autoincrement, Type text", nil, nil, nil) != SQLITE_OK
//        {
//            let err = String(cString: sqlite3_errmsg(db)!)
//            print("error at create Products table --> ", err)
//        }
//
//        // Create suggested items table
//        if sqlite3_exec(db, "create table if not exists Suggested Items (ID integer primary key autoincrement, ItemID integer", nil, nil, nil) != SQLITE_OK
//        {
//            let err = String(cString: sqlite3_errmsg(db)!)
//            print("error at create Suggested Items table --> ", err)
//        }
//
//        // Create users table
//        if sqlite3_exec(db, "create table if not exists Products (ID integer primary key autoincrement, Name text, Email text, Password text", nil, nil, nil) != SQLITE_OK
//        {
//            let err = String(cString: sqlite3_errmsg(db)!)
//            print("error at create User table --> ", err)
//        }
//
//        // Create user products table
//        if sqlite3_exec(db, "create table if not exists Products (ID integer primary key autoincrement, UserID integer, ProductID integer", nil, nil, nil) != SQLITE_OK
//        {
//            let err = String(cString: sqlite3_errmsg(db)!)
//            print("error at create User_Products table --> ", err)
//        }
//
//        // Create sqlite sequence table
//        if sqlite3_exec(db, "create table if not exists sqlite_sequence (name text, seq text", nil, nil, nil) != SQLITE_OK
//        {
//            let err = String(cString: sqlite3_errmsg(db)!)
//            print("error at create sqlite_sequence table --> ", err)
//        }
//    }

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
            
            for list in chosenItemList{
                chosenItem = Items(id: list.id, name: list.name, image: list.image, price: list.price, description: list.description, productID: list.productID)
            }
        }
    }
    
//    /// Get all items from database
//    func getAllItems() -> [String] {
//        
//        var itemList = [String]()
//        var pointer: OpaquePointer?
//        
//        let query = "select name from Items where ID = '" + String(1) + "'"
//        
//        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
//            let err = String(cString: sqlite3_errmsg(db)!)
//            print("There is an error at DBHelper.getAllItems() --> ", err)
//        }
//        
//        
//            while(sqlite3_step(pointer)) == SQLITE_ROW
//            {
//                print("enters while")
//                let name = String(cString:sqlite3_column_text(pointer, 0))
//                print(name)
//                itemList.append(name)
//            }
//            return itemList
//        
//    }// End of getAllUsers()
    
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
                    FetchItemByID(idToFetch: list.itemID)
                    suggestedItems.append(Items(id: chosenItem.id, name: chosenItem.name, image: chosenItem.image, price: chosenItem.price, description: chosenItem.description, productID: chosenItem.productID))
                                          
                //should be able to use the "Suggested Items" array to set the information for the suggested items in any of our collection views.
                }
            }
    
    //MARK:
    func insertUserOrders(userID: Int, itemID: Int){
        

            //Variables to hold the information for the User
            let userID = Int32(userID)
            let itemID = Int32(itemID)
            

            var stmt: OpaquePointer?
           // stores the query for the database.
            let query = "INSERT INTO Users_Orders (UserID,ItemID) VALUES (?,?)"
           
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
    
    //MARK: Function to add the users wishlist into the database.
    func insertUserWishlist(userID: Int, itemID: Int){
        

            //Variables to hold the information for the User
            let userID = Int32(userID)
            let itemID = Int32(itemID)
            

            var stmt: OpaquePointer?
           // stores the query for the database
            let query = "INSERT INTO Users_Wishlist (UserID,ItemID) VALUES (?,?)"
           
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
        
            //Holds the query.
            let query = "select * from suggested_items"
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
                let userID = sqlite3_column_int(stmt, 0)
                let itemID = sqlite3_column_int(stmt,1)
                //Appends the information to the array.
                userOrderList.append(UserOrder(userID: Int(userID), itemID: Int(itemID)))
            }
                //For loop fetches the item by the ID, appends the struct object to the array using chosenItem (set in the fetch call) and then clears chosenItem for the next iteration of the loop. At the end, suggested Items should be full of the items suggested, and chosenItem should be empty.
                for list in userOrderList{
                    FetchItemByID(idToFetch: list.itemID)
                    orderItems.append(Items(id: chosenItem.id, name: chosenItem.name, image: chosenItem.image, price: chosenItem.price, description: chosenItem.description, productID: chosenItem.productID))
                                          
                //should be able to use the "Suggested Items" array to set the information for the suggested items in any of our collection views.
                }
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
            let name = String(cString: sqlite3_column_text(stmt,1))
            let email = String(cString: sqlite3_column_text(stmt, 2))
            let password = String(cString: sqlite3_column_text(stmt, 3))
            let phone = String(cString: sqlite3_column_text(stmt, 4))
            
            //Adds the user to the global variable.
            GlobalVariables.userTryingToLogin = User(id: Int(id), name: name, email: email, password: password, phone: phone)
            
           
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
            let name = String(cString: sqlite3_column_text(stmt,1))
            let email = String(cString: sqlite3_column_text(stmt, 2))
            let password = String(cString: sqlite3_column_text(stmt, 3))
            let phone = String(cString: sqlite3_column_text(stmt, 4))
            
            //Adds the user to the global variable.
            GlobalVariables.userTryingToLogin = User(id: Int(id), name: name, email: email, password: password, phone: phone)
        
        }
    }
    
}
