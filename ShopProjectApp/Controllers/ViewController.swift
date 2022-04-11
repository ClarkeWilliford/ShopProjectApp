//
//  ViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/4/22.
//

import UIKit

var db = DBHelper()
/// Defines the home page view
let randomInt = Int.random(in: 0..<35)
var itemsWereOrdered = false
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    private let caller = DataFetcher()
    private var data = [Int]()
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
        return 350
    }
    
    /// Defines each cell at a specific row in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            //UICollectionView.dequeueConfiguredReusableCell(cell) as! CollectionTableViewCell
            cell.configure(with: models)
            return cell
        }
        else if(indexPath.row == 1){
            var cell = tableView.dequeueReusableCell(withIdentifier: "DealOfTheDayTableViewCell", for: indexPath) as! DealOfTheDayTableViewCell
            cell.dodImage.image = UIImage(named: db.itemsList[randomInt].image.replacingOccurrences(of: ".jpeg", with: ""))
            cell.dodName.text = db.itemsList[randomInt].name
            cell.dodPrice.text = db.itemsList[randomInt].price
            return cell
            
        } else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as! ExampleTableViewCell
            cell.itemImage.image = UIImage(named: db.itemsList[indexPath.row - 2].image)
            cell.itemName.text = db.itemsList[indexPath.row - 2].name
            cell.itemPrice.text = db.itemsList[indexPath.row - 2].price
            cellCount += 1
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            GlobalVariables.chosenItem = (Items(id: db.itemsList[randomInt].id, name: db.itemsList[randomInt].name, image: db.itemsList[randomInt].image, price: db.itemsList[randomInt].price, description: db.itemsList[randomInt].description, productID: db.itemsList[randomInt].productID))
        }
        else if indexPath.row > 1{
        GlobalVariables.chosenItem = (Items(id: db.itemsList[indexPath.row - 2].id, name: db.itemsList[indexPath.row - 2].name, image: db.itemsList[indexPath.row - 2].image, price: db.itemsList[indexPath.row - 2].price, description: db.itemsList[indexPath.row - 2].description, productID: db.itemsList[indexPath.row - 2].productID))
        }
        Navigation.goToItemDisplay()
}
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        db.OpenDatabase()
        db.FetchItems()
        db.fetchSuggestedItems()
        tableView.delegate = self
        tableView.dataSource = self
        var nib = UINib(nibName: "ExampleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ExampleTableViewCell")
        nib = UINib(nibName: "DealOfTheDayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DealOfTheDayTableViewCell")
        tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        models.append(Model(text: db.suggestedItems[0].name, imageName: db.suggestedItems[0].image, price: db.suggestedItems[0].price))
        models.append(Model(text: db.suggestedItems[1].name, imageName: db.suggestedItems[1].image, price: db.suggestedItems[1].price))
        models.append(Model(text: db.suggestedItems[2].name, imageName: db.suggestedItems[2].image, price: db.suggestedItems[2].price))
        models.append(Model(text: db.suggestedItems[3].name, imageName: db.suggestedItems[3].image, price: db.suggestedItems[3].price))
        models.append(Model(text: db.suggestedItems[4].name, imageName: db.suggestedItems[4].image, price: db.suggestedItems[4].price))


    }

    /// Update table view upon scrolling down
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        caller.fetchData(pagination: false, completion: { [weak self] result in
            switch result{
            case .success(let data):
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
    
    var count = 0
    
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
                    if self?.count == 0{
                        self?.data.append(5)
                        self?.data.append(6)
                        self?.data.append(7)
                        self?.data.append(8)
                        self?.data.append(9)
                        self?.count += 1
                    }
                    if(((self?.data.count)) != nil){
                        if((self?.data.count)! <= 35){
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
                        }
                    }
                    else {
                        print("do nothing")
                    }
                case .failure(_):
                    break
                }
            }
        }
    }

    /// modelView struct that defines the model for what data gets displayed in table view cells
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
