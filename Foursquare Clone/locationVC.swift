//
//  locationVC.swift
//  Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 19/12/2016.
//  Copyright © 2016 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class locationVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!

    var manager = CLLocationManager()
    var chosenLatitude = ""
    var chosenLongitude = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(locationVC.press(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chosenLatitude = ""
        chosenLongitude = ""
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        manager.stopUpdatingLocation()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }

    
    
    func press(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = "the name of the place that we have chosen in the previous UIView"
            annotation.subtitle = "the type of the place "
            
            mapView.addAnnotation(annotation)
            
            self.chosenLatitude = String(coordinates.latitude)
            self.chosenLongitude = String(coordinates.longitude)
            
            
        }
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        
        let object = PFObject(className: "Places")
        object["name"] = name
        object["type"] = type
        object["atmosphere"] = atmosphere
        object["latitude"] = self.chosenLatitude
        object["longitude"] = self.chosenLongitude
        
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        
        object["image"] = PFFile(name: "image.jpg", data: imageData!)
        
        object.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPlace"), object: nil)
                
                self.performSegue(withIdentifier: "fromLocationtoPlacesSegue", sender: nil)

                
            }
        }
        
    }
  
}
