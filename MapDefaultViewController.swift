//
//  MapDefaultViewController.swift
//  LocationDemo1
//
//  Created by Stan Shockley on 4/7/22.
//

import UIKit
import MapKit

class MapDefaultViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let calendar = Calendar.current
        
        let lc = CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417)
        let ms = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let rg = MKCoordinateRegion(center: lc, span: ms)
        kapv.setRegion(rg, animated: true)
        let annot = MKPointAnnotation()
        annot.coordinate = lc
        annot.title = "Customer Location"
        annot.subtitle = ""
        kapv.addAnnotation(annot)
        
    }
    
    
}


