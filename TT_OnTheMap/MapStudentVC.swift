//
//  MapStudentVC.swift
//  TT_OnTheMap
//
//  Created by Tigran Tshorokhyan on 9/3/17.
//  Copyright © 2017 Tigran Tshorokhyan. All rights reserved.
//

import UIKit
import MapKit

class MapStudentVC: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
    
    var placeMark: CLPlacemark!
    
    var mapString: String!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var webLink: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        let user = OnTheMapClient.sharedInstance().user!
        let studentLocation = StudentLocation(uniqueKey: user.uniqueKey, firstName: user.firstName, lastName: user.lastName, mapString: self.mapString, mediaURL: webLink.text!, latitude: (placeMark.location?.coordinate.latitude)!, longitude: (placeMark.location?.coordinate.longitude)!)
        let controller = storyboard!.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        present(controller, animated: true, completion: nil)
        OnTheMapClient.sharedInstance().postStudentLocation(studentLocation) { (success, errorString) in
            performUIUpdatesOnMain {
                
                if success {
                    print(success)
                }else {
                }
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webLink.delegate = self
        placePin()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    private func placePin() {
        let mkAnnotation = MKPointAnnotation()
        print("placeMark=\(placeMark)")
        let lat = CLLocationDegrees((placeMark.location?.coordinate.latitude)!)
        let long = CLLocationDegrees((placeMark.location?.coordinate.longitude)!)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mkAnnotation.coordinate = coordinate
        mapView.addAnnotation(mkAnnotation)
        
        var mkRegion = MKCoordinateRegion()
        mkRegion.center = coordinate
        mapView.setRegion(mkRegion, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView?.animatesDrop = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    


}

