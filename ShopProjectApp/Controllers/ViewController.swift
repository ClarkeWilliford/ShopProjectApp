//
//  ViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/4/22.
//

import UIKit

var db = DBHelper()
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let caller = DataFetcher()
    private var data = [Int]()
    var models = [Model]()
    var itemDetailsCollection = [["magnifyingglass", "Shoe1", "$29.99"],["pencil", "Shoe2", "$150.00"],["scribble", "Shoe2", "$20.00"],["highlighter", "Shoe4", "$34.99"]]
    
    var cellCount = 0
    var dodCollection = ["scribble", "dodPrice", "dodName"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + itemDetailsCollection.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            return cell
        }
        else if(indexPath.row == 1){
            var cell = tableView.dequeueReusableCell(withIdentifier: "DealOfTheDayTableViewCell", for: indexPath) as! DealOfTheDayTableViewCell
            cell.dodImage.setImage(UIImage(systemName: dodCollection[0]), for: .normal)
            cell.dodName.text = dodCollection[2]
            cell.dodPrice.text = dodCollection[1]
            return cell
            
        } else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as! ExampleTableViewCell
            cell.button1.setImage(UIImage(systemName: itemDetailsCollection[0][0]), for: .normal)
            cell.button2.setImage(UIImage(systemName: itemDetailsCollection[1][0]), for: .normal)
            cell.button3.setImage(UIImage(systemName: itemDetailsCollection[2][0]), for: .normal)
            cell.button4.setImage(UIImage(systemName: itemDetailsCollection[3][0]), for: .normal)
            cell.item1Name.text = itemDetailsCollection[0][1]
            cell.item2Name.text = itemDetailsCollection[1][1]
            cell.item3Name.text = itemDetailsCollection[2][1]
            cell.item4Name.text = itemDetailsCollection[3][1]
            cell.item1Price.text = itemDetailsCollection[0][2]
            cell.item2Price.text = itemDetailsCollection[1][2]
            cell.item3Price.text = itemDetailsCollection[2][2]
            cell.item4Price.text = itemDetailsCollection[3][2]
            cellCount += 1
            return cell
        }
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        var nib = UINib(nibName: "ExampleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ExampleTableViewCell")
        nib = UINib(nibName: "DealOfTheDayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DealOfTheDayTableViewCell")
        tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        models.append(Model(text: "elden ring", imageName: "eldenRing"))
        models.append(Model(text: "colgate", imageName: "colgate30Advanced"))
        models.append(Model(text: "cottonelle", imageName: "Cottonelle"))
        models.append(Model(text: "jordans", imageName: "jordanNavy"))
        models.append(Model(text: "Kirby", imageName: "KirbyGame"))
        models.append(Model(text: "adidas", imageName: "adidasBlack"))
        models.append(Model(text: "jacket", imageName: "carharrtjacket"))
        models.append(Model(text: "cottonelle", imageName: "Cottonelle"))
        models.append(Model(text: "jordans", imageName: "jordanNavy"))
        models.append(Model(text: "Kirby", imageName: "KirbyGame"))
        models.append(Model(text: "adidas", imageName: "adidasBlack"))
        models.append(Model(text: "jacket", imageName: "carharrtjacket"))
        models.append(Model(text: "cottonelle", imageName: "Cottonelle"))
        models.append(Model(text: "jordans", imageName: "jordanNavy"))
        models.append(Model(text: "Kirby", imageName: "KirbyGame"))
    }

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
    
    private func createSpinnerFooter()-> UIView{
        let footerView = UIView(frame: CGRect(x:0,y:0,width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
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
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }

    struct Model{
        let text: String
        let imageName: String
        init(text: String, imageName: String){
            self.text = text
            self.imageName = imageName
        }
    }
}


