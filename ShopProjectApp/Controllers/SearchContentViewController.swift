//
//  SearchContentViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/17/22.
//

import UIKit

/// Defines the properties and methods of the search content view, which is updated by the search bar
class SearchContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data = [String]()
    var filteredData: [String]?
    @IBOutlet weak var searchTableView: UITableView!
    
    /// Loads database values and stores in variables of this file, contains notification observers to update tableviews based on actions from other views, and sets the delegate and data source of the tableview
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entered search content view")
        db.OpenDatabase()
        db.FetchItems()
        for names in 0..<db.itemsList.count{
            if !data.contains(db.itemsList[names].name){
                data.append(db.itemsList[names].name)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(newStringExists), name: Notification.Name("newSearchString"), object: nil)
        if(GlobalVariables.searchBar.isEmpty){
            filteredData = data
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showSearchContent), name: Notification.Name("showSearchContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideSearchContent), name: Notification.Name("hideSearchContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name("reloadTableView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView2), name: Notification.Name("reloadTableView2"), object: nil)

        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    
    /// Defines the number of rows in the table view
    /// - Parameters:
    ///   - tableView: table view holds the name of items
    ///   - section: the number of sections that contains the number of rows
    /// - Returns: the value of the number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? data.count
    }
    
    /// Sets the data in the specific cell of the database
    /// - Parameters:
    ///   - tableView: table view cells hold item name
    ///   - indexPath: the index of the row's path in the table view
    /// - Returns: the cell that holds that information of the items, for this table view, the information would be the item's name
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData?[indexPath.row]
        return cell
    }
    
    /// Uses the selected row of the table view to access the chosen item from the database, store it in global variables to transtition to next page and display that data
    /// - Parameters:
    ///   - tableView: table view cells hold item name
    ///   - indexPath: the index of the row's path in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("inside content")
        db.FetchItemByName(nameToFetch: data[indexPath.row])
        print(GlobalVariables.chosenItem)
        Navigation.goToItemDisplay()
    }
    
    /// Shows the search bar
    @objc func showSearchContent(){
        searchTableView.isHidden = false
    }
    /// Hides the search bar
    @objc func hideSearchContent(){
        searchTableView.isHidden = true
    }
    /// Reloads/Loads the first table view data for the second table view in the view
    @objc func reloadTableView(){
        filteredData?.removeAll()
        filteredData = data
        self.searchTableView.reloadData()
    }
    /// Reloads/Loads the search table view data for the second table view in the view
    @objc func reloadTableView2(){
        filteredData?.removeAll()
        filteredData = data
        self.searchTableView.reloadData()
    }
    /// Uses data stored in global variables to check for new string input inside the search bar
    @objc func newStringExists(){
        filteredData?.removeAll()
        for word in data{
            if(word.uppercased().contains(GlobalVariables.searchBar[GlobalVariables.searchBar.count - 1].uppercased())){
                filteredData?.append(word)
            }
        }
        self.searchTableView.reloadData()
        if(filteredData!.isEmpty){
            filteredData = data
            self.searchTableView.reloadData()
        }
    }

}
