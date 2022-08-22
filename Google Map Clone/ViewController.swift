//
//  ViewController.swift
//  Google Map Clone
//
//  Created by Tejesh singh on 01/08/22.
//

import GoogleMaps
import UIKit


class ViewController: UIViewController, CLLocationManagerDelegate,GMSMapViewDelegate {
    @IBOutlet weak var GMapView: GMSMapView!
    
    let LocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.delegate = self
        GMapView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GMapView.settings.compassButton = true
        GMapView.settings.myLocationButton = true
        GMapView.isMyLocationEnabled = true
        LocationManager.requestWhenInUseAuthorization()
        LocationManager.requestLocation()
        LocationManager.startUpdatingHeading()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let coordinates = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        self.GMapView.animate(to: camera)
        LocationManager.stopUpdatingLocation()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        marker.title = "Varanasi"
        marker.snippet = "India"
        marker.map = mapView
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
        
}

