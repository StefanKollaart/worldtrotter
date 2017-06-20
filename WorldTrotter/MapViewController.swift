//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Stefan Kollaart on 19-06-17.
//  Copyright © 2017 Stefan Kollaart. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    }
}
