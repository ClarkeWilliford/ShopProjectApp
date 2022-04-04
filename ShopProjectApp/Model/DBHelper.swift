//
//  DBHelper.swift
//  ShopGroupApp
//
//  Created by Clarke Williford on 3/30/22.
//

import Foundation
import SQLite3

class DBHelper{

    static var dataBase: OpaquePointer?
    
    //array of structs to hold item information
    var itemsList = [Items]()
    //array of class instance to hold information on a single item.
    var chosenItemList = [Items]()
    var chosenItem = Items(id: 0, name: "", image: "", price: "", description: "", productID: 0)
    //arrauys to hold the suggested items.
    var suggestedList = [Suggested]()
    var suggestedItems = [Items]()

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
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
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
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
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
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
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
    
    //MARK: function to pull the suggested items and store them.
    func fetchSuggestedItems(){
        
            //Holds the query.
            let query = "select * from suggested_items"
            //Holds the pointer.
            var stmt : OpaquePointer?
            //Queries the database and prints any error.
            if sqlite3_prepare_v2(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
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
        }
