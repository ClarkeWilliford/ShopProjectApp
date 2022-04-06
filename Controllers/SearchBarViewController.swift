//
//  SearchBarViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/4/22.
//

import UIKit

class SearchBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        //when search button clicked, add search bar
        let searchButton = UIButton(frame: CGRect(x: 250, y: 15, width: 30, height: 20))
        searchButton.backgroundColor = .clear
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        //button.setTitle("Test Button", for: .normal)
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(searchButton)
        
        //when notificaiton button clicked, navigate to notificaiton page
        let notificationButton = UIButton(frame: CGRect(x: 300, y: 15, width: 30, height: 20))
        notificationButton.backgroundColor = .clear
        notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        //button.setTitle("Test Button", for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationButtonAction), for: .touchUpInside)
        self.view.addSubview(notificationButton)
        
        
        let companyLogo = UILabel(frame: CGRect(x: 50, y: 15, width: 100, height: 20))
        companyLogo.text = "GroupApp"
        
        self.view.addSubview(companyLogo)
    }
    
    @objc func notificationButtonAction(_sender: UIButton!){
        print("notif button pressed")
    }

}
