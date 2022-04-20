//
//  TrackerViewController.swift
//  ShopProjectApp
//
//  Created by Clarke Williford on 4/15/22.
//

import UIKit
import MapKit
import Firebase
import Messages
class TrackerViewController: UIViewController {
    
    //Outlet Block
    @IBOutlet weak var kapv: MKMapView!
    @IBOutlet weak var warehouseLabel: UILabel!
    @IBOutlet weak var daysSince: UILabel!
    @IBOutlet weak var plane: UIImageView!
    
    //sets up the x and y coordinates to be changed later.
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    
    //generates a random number for the flight path.
    var n = Int.random(in: 1...3)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instantiates the map for the mapview.
        MapDefaultViewController()
        
        //Variables to hold the various dates needed
        let calendar = Calendar.current
        let time = Date()
        var orderDate1 = Date(timeInterval: -86400, since: time)
        let date1 = calendar.startOfDay(for: orderDate1)
        let date2 = calendar.startOfDay(for: time)
        //changes the date
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        print(components.day!)
        
    }
    
    //action that causes the map to display where the shipment is and animate its movement.
    @IBAction func Track(_ sender: Any) {
        //Sets up the date information.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        //crates the variable to hold the current date.
        var time = Date()
        //creates time intervales to show movement.
        var orderDate0 = Date(timeInterval: -52, since: time)
        var orderDate1 = Date(timeInterval: -86400, since: time)
        var orderDate2 = Date(timeInterval: -172800, since: time)
        var orderDate3 = Date(timeInterval: -259200, since: time)
        
        //This variable sets up the initial version of the variable which will then be changed based on the random number earlier to show 4 possible flight paths for the order.
        var timeSinceOrder = DateInterval(start: orderDate0, end: time)

        //This swich case takes the random number generated earlier and then changes the "timeSinceOrder" variable to one of 4 possible settings.
        switch n{
        case 0:
            timeSinceOrder = DateInterval(start: orderDate0, end: time)
        case 1:
            timeSinceOrder = DateInterval(start: orderDate1, end: time)
        case 2:
            timeSinceOrder = DateInterval(start: orderDate2, end: time)
        case 3:
            timeSinceOrder = DateInterval(start: orderDate3, end: time)
        default:
            print("this will never happen")
        }
        
        //These variables hold information used to make the plane image move on the map.
        let orderPeriodInSeconds = ((timeSinceOrder.duration) / 3600 / 24)
        let orderPeriodInDaysInt = Int(orderPeriodInSeconds)
        let orderPeriodInDays = String(orderPeriodInDaysInt)
        var currentShippingLocation = orderPeriodInDays
        //based on the "timeSinceOrder" variable, the switch statement will display different information at the top of the map and will start and specific locations and move to specific end points.
        switch currentShippingLocation {
        case "1":
            daysSince.text = orderPeriodInDays
            warehouseLabel.text = "Louisville KY Shipping Location"
            let lc = CLLocationCoordinate2D(latitude: 38.2527, longitude: -85.7585)
            let ms = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let rg = MKCoordinateRegion(center: lc, span: ms)
            kapv.setRegion(rg, animated: true)
            let annot = MKPointAnnotation()
            annot.coordinate = lc
            annot.title = "Louisville KY Shipping Location"
            kapv.addAnnotation(annot)
            movePlane(12, 472)
        case "2":
            daysSince.text = orderPeriodInDays
            warehouseLabel.text = "Catskill NY Shipping Location"
            let lc = CLLocationCoordinate2D(latitude: 42.2173, longitude: -73.8646)
            let ms = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let rg = MKCoordinateRegion(center: lc, span: ms)
            kapv.setRegion(rg, animated: true)
            let annot = MKPointAnnotation()
            annot.coordinate = lc
            annot.title = "Catskill NY Shipping Location"
            kapv.addAnnotation(annot)
            movePlane(68, 433)
        case "3":
            daysSince.text = orderPeriodInDays
            warehouseLabel.text = "Grand Rapids MI Shipping Location"
            let lc = CLLocationCoordinate2D(latitude: 42.9634, longitude: -85.6681)
            let ms = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let rg = MKCoordinateRegion(center: lc, span: ms)
            kapv.setRegion(rg, animated: true)
            let annot = MKPointAnnotation()
            annot.coordinate = lc
            annot.title = "Grand Rapids MI Shipping Location"
            kapv.addAnnotation(annot)
            movePlane(155, 300)
        default:
            daysSince.text = "0"
            warehouseLabel.text = "ShopGroup Shipping HQ"
            let lc = CLLocationCoordinate2D(latitude: 33.2000, longitude: -117.2425)
            let ms = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let rg = MKCoordinateRegion(center: lc, span: ms)
            kapv.setRegion(rg, animated: true)
            let annot = MKPointAnnotation()
            annot.coordinate = lc
            annot.title = "ShopGroup Shipping Headquarters"
            kapv.addAnnotation(annot)
            movePlane(200, 350)
        }
    
    }
    ///This is the function that actually moves the plane from it's starting point to it's end point. Upon completion, add delivery time to notificationItems in global variables to update the notification count in the search bar
    func movePlane(_ x: CGFloat, _ y: CGFloat) {
        UIView.animate(withDuration: 10.0, delay: 1.5, options: .curveLinear, animations: {
            
            self.plane.center.x = x
            self.plane.center.y = y
            
        }, completion: {_ in
            GlobalVariables.notificationItems.append("Order completed on \(Date())")
        })
    }
    
    /// Upon dismissing this view, the notification does the actual update of the notification count in the search bar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            NotificationCenter.default.post(name: Notification.Name("updateNotificationNumber"), object: nil)
        }
    }

}
