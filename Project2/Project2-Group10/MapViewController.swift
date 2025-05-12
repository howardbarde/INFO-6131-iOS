//
//  MapViewController.swift
//  Project2-Group10
//
//  Created by Olivia Howard on 2024-12-01.
//

import UIKit
import MapKit
//Map Detail View Controller
class MapViewController: UIViewController {
    //Variables for Location Title, Longitude, and Latitude
    var locTitle: String?
    var lat: Double?
    var long: Double?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        addAnnotation(location: getLocation())
        
    }

    private func getLocation()-> CLLocation{
        return CLLocation(latitude: lat ?? 0.00, longitude: long ?? 0.00)
    }
    
    //Add annotation to mapView
    private func addAnnotation(location: CLLocation){
        let annotation = MyAnnotation(coordinate: location.coordinate, title: locTitle ?? "my title")
        
        mapView.addAnnotation(annotation)
    }
    
    //Function to setup mapView with region, camera boundary, and camera zoom
    private func setupMap(){

        let location =  CLLocation(latitude: lat ?? 0.00, longitude: long ?? 0.00)
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(region, animated: true)
        
        let boundary = MKMapView.CameraBoundary(coordinateRegion: region)
        mapView.setCameraBoundary(boundary, animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000.0)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
}

class MyAnnotation:NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title:String){
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
    
}
