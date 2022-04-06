//
//  TabBarViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/6/22.
//

import UIKit

class TabBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //when search button clicked, add search bar
        let searchButton = UIButton(frame: CGRect(x: 250, y: 15, width: 30, height: 20))
        searchButton.backgroundColor = .yellow
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        //button.setTitle("Test Button", for: .normal)
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(searchButton)
        
        //when notificaiton button clicked, navigate to notificaiton page
        let notificationButton = UIButton(frame: CGRect(x: 300, y: 15, width: 30, height: 20))
        notificationButton.backgroundColor = .yellow
        notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        //button.setTitle("Test Button", for: .normal)
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(notificationButton)
    }

}
