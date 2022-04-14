//
//  ViewController.swift
//  LocationDemo1
//
//  Created by Stan Shockley on 4/6/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var kapv: MKMapView!
    @IBOutlet weak var warehouseLabel: UILabel!
    @IBOutlet weak var daysSince: UILabel!
    @IBOutlet weak var plane: UIImageView!
    
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapDefaultViewController()
        
        let calendar = Calendar.current
        let time = Date()
        var orderDate1 = Date(timeInterval: -86400, since: time)
        let date1 = calendar.startOfDay(for: orderDate1)
        let date2 = calendar.startOfDay(for: time)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        print(components.day!)
        
    }
    
    @IBAction func Track(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        var time = Date()
        
        var orderDate0 = Date(timeInterval: -52, since: time)
        var orderDate1 = Date(timeInterval: -86400, since: time)
        var orderDate2 = Date(timeInterval: -172800, since: time)
        var orderDate3 = Date(timeInterval: -259200, since: time)
        
        //To test different shipping location scenarios: un-comment one of the following 4 lines, leaving the remaining 3 commented, in order to change the amount of time since the order was placed. This will result in the order being tracked to different starting locations
        
        var timeSinceOrder = DateInterval(start: orderDate0, end: time)
//        var timeSinceOrder = DateInterval(start: orderDate1, end: time)
//        var timeSinceOrder = DateInterval(start: orderDate2, end: time)
//        var timeSinceOrder = DateInterval(start: orderDate3, end: time)
        
        let orderPeriodInSeconds = ((timeSinceOrder.duration) / 3600 / 24)
        let orderPeriodInDaysInt = Int(orderPeriodInSeconds)
        let orderPeriodInDays = String(orderPeriodInDaysInt)
        var currentShippingLocation = orderPeriodInDays
        
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
    
    func movePlane(_ x: CGFloat, _ y: CGFloat) {
        
        UIView.animate(withDuration: 10.0, delay: 1.5, options: .curveLinear, animations: {
            
            self.plane.center.x = x
            self.plane.center.y = y
            
        }, completion: nil)
        
    }

}
