//
//  SearchContentViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/17/22.
//

import UIKit

class SearchContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data = [String]()
    var filteredData: [String]?

    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entered search content view")
        db.OpenDatabase()
        db.FetchItems()
//        if !data.isEmpty{
//            data.removeAll()
//        }
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("data count")
        print(data.count)
        return filteredData?.count ?? data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("inside content")
        db.FetchItemByName(nameToFetch: data[indexPath.row])
        print(GlobalVariables.chosenItem)
        Navigation.goToItemDisplay()
    }

    @objc func showSearchContent(){
        searchTableView.isHidden = false
    }
    @objc func hideSearchContent(){
        searchTableView.isHidden = true
    }
    @objc func reloadTableView(){
        filteredData?.removeAll()
        filteredData = data
        self.searchTableView.reloadData()
    }
    @objc func reloadTableView2(){
        print("inside reload 2")
        filteredData?.removeAll()
        filteredData = data
        self.searchTableView.reloadData()
    }
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
