//
//  DBHelper.swift
//  ShopGroupApp
//
//  Created by Clarke Williford on 3/30/22.
//

import Foundation
import SQLite3

class DBHelper {

    var dataBase : OpaquePointer?

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
    
    
    
    
    
}
