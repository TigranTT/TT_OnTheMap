//
//  MapVC.swift
//  TT_OnTheMap
//
//  Created by Tigran Tshorokhyan on 8/27/17.
//  Copyright © 2017 Tigran Tshorokhyan. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func refreshButton(_ sender: Any) {
        reloadData()
    }
    
    
    
    @IBAction func addStudentLocation(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "AddLocation") as! AddLocationVC
        
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func performLogOut(_ sender: Any) {
        print("logout")
        OnTheMapClient.sharedInstance().logoutWithVC(self) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogout()
                }else {
                    if let errorString = errorString {
                        self.displayError(errorString)
                    }
                }
            }
        }
    }
    
    
    private func completeLogout() {
        dismiss(animated: true, completion: nil)
    }
    
    private func displayError(_ errorString: String){
        print(errorString)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView?.animatesDrop = true
            let callOutButton = UIButton(type: .detailDisclosure)
            pinView!.rightCalloutAccessoryView = callOutButton
            
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation!
        if let subtitle = annotation.subtitle {
            if let url = subtitle {
                if let actualURL = URL(string: url) {
                    UIApplication.shared.open(actualURL, options: [:], completionHandler: nil)
                }
            }
            
        }
    }
    
    private func reloadData() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        OnTheMapClient.sharedInstance().getStudentLocations(self) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    print("mapView success")
                    
                    let studentLocations: [StudentLocation] = StudentLocationCollection.all
                    var annotations = [MKPointAnnotation]()
                    for studentLocation in studentLocations {
                        let lat = CLLocationDegrees(studentLocation.latitude)
                        let long = CLLocationDegrees(studentLocation.longitude)
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = "\(studentLocation.firstName) \(studentLocation.lastName)"
                        annotation.subtitle = "\(studentLocation.mediaURL)"
                        annotations.append(annotation)
                        
                    }
                    self.mapView.addAnnotations(annotations)
                    
                }
            }
            
        }
        
    }


}
