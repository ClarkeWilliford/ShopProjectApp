//
//  HistoryViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/17/22.
//

import UIKit
import SQLite3

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.historyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        cell.historyCellImage.image = UIImage(named: GlobalVariables.historyItems[indexPath.row].image)
        cell.historyCellNameLabel.text = GlobalVariables.historyItems[indexPath.row].name
        cell.historyCellPriceLabel.text = GlobalVariables.historyItems[indexPath.row].price
        cell.historyCellImage.clipsToBounds = true
        cell.historyCellImage.contentMode = .scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalVariables.chosenItem = (Items(id: database.historyItems[indexPath.row].id, name: database.historyItems[indexPath.row].name, image: database.historyItems[indexPath.row].image, price: database.historyItems[indexPath.row].price, description: database.historyItems[indexPath.row].description, productID: database.historyItems[indexPath.row].productID))
        GlobalVariables.userHistory.append(GlobalVariables.chosenItem)
        Navigation.goToItemDisplay()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    var database = DBHelper()

    @IBOutlet weak var historyTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.OpenDatabase()
        database.historyItems = [Items]()
        database.userHistoryList = [UserOrder]()
        GlobalVariables.historyItems = [Items]()
        database.fetchUserHistory()
        
        
    }
    

    

}
