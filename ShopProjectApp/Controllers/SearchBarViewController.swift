//
//  SearchBarViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/4/22.
//

import UIKit

class SearchBarViewController: UIViewController, UISearchBarDelegate {

    let searchBar = UISearchBar(frame: CGRect(x: 50, y: 15, width: 300, height: 20))
    let searchButton = UIButton(frame: CGRect(x: 300, y: 15, width: 30, height: 20))
    let companyLogo = UILabel(frame: CGRect(x: 50, y: 15, width: 100, height: 20))
    let hideSearchButton = UIButton(frame: CGRect(x: 25, y: 15, width: 30, height: 20))
    let notificationButton = UIButton(frame: CGRect(x: 350, y: 15, width: 30, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        view.backgroundColor = .yellow
        
        searchBar.backgroundColor = .clear
        self.view.addSubview(searchBar)
        searchBar.isHidden = true
        
        //when search button clicked, add search bar
        searchButton.backgroundColor = .clear
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        //button.setTitle("Test Button", for: .normal)
        searchButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(searchButton)
        
        //when notificaiton button clicked, navigate to notificaiton page
        notificationButton.backgroundColor = .clear
        notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        //button.setTitle("Test Button", for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationButtonAction), for: .touchUpInside)
        self.view.addSubview(notificationButton)
        
        //when search button clicked, add search bar
        hideSearchButton.backgroundColor = .clear
        hideSearchButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        //button.setTitle("Test Button", for: .normal)
        hideSearchButton.addTarget(self, action: #selector(hideSearchButtonAction), for: .touchUpInside)
        self.view.addSubview(hideSearchButton)
        hideSearchButton.isHidden = true
        
        companyLogo.text = "GroupApp"
        
        self.view.addSubview(companyLogo)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        GlobalVariables.searchBar.append(searchText)
        NotificationCenter.default.post(name: Notification.Name("newSearchString"), object: nil)
    }
    
    @objc func notificationButtonAction(_sender: UIButton!){
        print("notif button pressed")
    }
    @objc func buttonAction(_sender: UIButton!){
        searchBar.isHidden = false
        searchButton.isHidden = true
        companyLogo.isHidden = true
        hideSearchButton.isHidden = false
        NotificationCenter.default.post(name: Notification.Name("showSearchContent"), object: nil)

    }
    @objc func hideSearchButtonAction(_sender: UIButton!){
        searchBar.isHidden = true
        searchButton.isHidden = false
        companyLogo.isHidden = false
        hideSearchButton.isHidden = true
        NotificationCenter.default.post(name: Notification.Name("hideSearchContent"), object: nil)
    }

}
