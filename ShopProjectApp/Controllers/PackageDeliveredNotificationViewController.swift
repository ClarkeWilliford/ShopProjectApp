//
//  PackageDeliveredNotificationViewController.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/20/22.
//

import UIKit

/// Updates the delivery in the notification button of the search bar at the top of every view controller
class PackageDeliveredNotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var deliveredPackages = GlobalVariables.notificationItems
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveredPackages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = deliveredPackages[deliveredPackages.count - indexPath.row - 1]
        return cell
    }
    

    @IBOutlet weak var notificationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    /// Updates that the notification count should be cleared
    /// - Parameter animated: swiping down to dismiss the view
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            NotificationCenter.default.post(name: Notification.Name("clearNotificationNumber"), object: nil)
        }
    }


}
