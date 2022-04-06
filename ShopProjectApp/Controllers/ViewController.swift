//
//  ViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/4/22.
//

import UIKit

var db = DBHelper()
/// Defines the home page view

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    private let caller = DataFetcher()
    private var data = [0,1,2,3]
    var models = [Model]()
    var itemDetailsCollection = [["magnifyingglass", "Shoe1", "$29.99"],["pencil", "Shoe2", "$150.00"],["scribble", "Shoe2", "$20.00"],["highlighter", "Shoe4", "$34.99"]]
    var cellCount = 0
    var dodCollection = ["scribble", "dodPrice", "dodName"]
    
    /// Defines number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + data.count
    }
    
    /// Defines height of table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    /// Defines each cell at a specific row in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            return cell
        }
        else if(indexPath.row == 1){
            var cell = tableView.dequeueReusableCell(withIdentifier: "DealOfTheDayTableViewCell", for: indexPath) as! DealOfTheDayTableViewCell
            cell.dodImage.setImage(UIImage(named: db.itemsList[0].image.replacingOccurrences(of: ".jpeg", with: "")), for: .normal)
            cell.dodName.text = db.itemsList[0].name
            cell.dodPrice.text = db.itemsList[0].price
            print("inside dod")
            print(db.itemsList[0].image.replacingOccurrences(of: ".jpeg", with: ""))
            print(db.itemsList[0].name)
            print(db.itemsList[0].price)
            return cell
            
        } else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as! ExampleTableViewCell
            print(db.itemsList[indexPath.row - 2].name)
            cell.itemImage.setImage(UIImage(named: db.itemsList[indexPath.row - 2].image), for: .normal)
            cell.itemName.text = db.itemsList[indexPath.row - 2].name
            cell.itemPrice.text = db.itemsList[indexPath.row - 2].price
            cellCount += 1
            return cell
        }
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        db.OpenDatabase()
        db.FetchItems()
//        for list in db.itemsList{
//            print("the item id is \(list.id) the name is \(list.name) the price is \(list.price) the description is \(list.description)")
//        }
        print(db.itemsList.count)
        print(db.itemsList)
        tableView.delegate = self
        tableView.dataSource = self
        var nib = UINib(nibName: "ExampleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ExampleTableViewCell")
        nib = UINib(nibName: "DealOfTheDayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DealOfTheDayTableViewCell")
        tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        //no such table: suggested_items error. gives empty suggested items. probably because suggested items name in database is Suggested Items and not suggested_items. needs to be updated.
//        print("suggested items")
//        db.fetchSuggestedItems()
//        print(db.suggestedItems)
        
        
        models.append(Model(text: db.itemsList[0].name, imageName: db.itemsList[0].image, price: db.itemsList[0].price))
        models.append(Model(text: db.itemsList[1].name, imageName: db.itemsList[1].image, price: db.itemsList[1].price))
        models.append(Model(text: db.itemsList[2].name, imageName: db.itemsList[2].image, price: db.itemsList[2].price))
        models.append(Model(text: db.itemsList[3].name, imageName: db.itemsList[3].image, price: db.itemsList[3].price))
        models.append(Model(text: db.itemsList[4].name, imageName: db.itemsList[4].image, price: db.itemsList[4].price))
        models.append(Model(text: db.itemsList[5].name, imageName: db.itemsList[5].image, price: db.itemsList[5].price))
        models.append(Model(text: db.itemsList[6].name, imageName: db.itemsList[6].image, price: db.itemsList[6].price))
        models.append(Model(text: db.itemsList[7].name, imageName: db.itemsList[7].image, price: db.itemsList[7].price))
        models.append(Model(text: db.itemsList[8].name, imageName: db.itemsList[8].image, price: db.itemsList[8].price))
        models.append(Model(text: db.itemsList[9].name, imageName: db.itemsList[9].image, price: db.itemsList[9].price))
        models.append(Model(text: db.itemsList[10].name, imageName: db.itemsList[10].image, price: db.itemsList[10].price))

    }

    /// Update table view upon scrolling down
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        print("viewlayoutsubviews")
        caller.fetchData(pagination: false, completion: { [weak self] result in
            switch result{
            case .success(let data):
                print("appendable data")
                print(data)
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            
            }
        })
    }
    
    
    /// Display spinner when paginating
    private func createSpinnerFooter()-> UIView{
        let footerView = UIView(frame: CGRect(x:0,y:0,width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    /// Determine if page reaches certain location to begin paginating
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height){
            guard !caller.isPaginating else{
                return
            }
            
            self.tableView.tableFooterView = createSpinnerFooter()
            caller.fetchData(pagination: true){
                [weak self] result in
                DispatchQueue.main.async {
                    
                    self?.tableView.tableFooterView = nil
                }
                
                switch result{
                case .success(let moreData):
                    self?.data.append(contentsOf: moreData)
                    print(self?.data)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }

    /// Struct that defines the model for what data gets displayed in table view cells
    struct Model{
        let text: String
        let imageName: String
        let price: String
        init(text: String, imageName: String, price: String){
            self.text = text
            self.imageName = imageName
            self.price = price
        }
    }
}
