//
//  SearchContentViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/17/22.
//

import UIKit

class SearchContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data = [String]()
    var filteredData: [String]!

    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entered search content view")
        db.OpenDatabase()
        db.FetchItems()
        for names in 0..<db.itemsList.count{
            data.append(db.itemsList[names].name)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(newStringExists), name: Notification.Name("newSearchString"), object: nil)
        if(GlobalVariables.searchBar.isEmpty){
            filteredData = data
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showSearchContent), name: Notification.Name("showSearchContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideSearchContent), name: Notification.Name("hideSearchContent"), object: nil)

        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count ?? data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }

    @objc func showSearchContent(){
        searchTableView.isHidden = false
    }
    @objc func hideSearchContent(){
        searchTableView.isHidden = true
    }
    
    @objc func newStringExists(){
        filteredData.removeAll()
        for word in data{
            if(word.uppercased().contains(GlobalVariables.searchBar[GlobalVariables.searchBar.count - 1].uppercased())){
                filteredData.append(word)
            }
        }
        self.searchTableView.reloadData()
        if(filteredData!.isEmpty){
            filteredData = data
            self.searchTableView.reloadData()
        }
    }

}
