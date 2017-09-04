//
//  AddLocationVC.swift
//  TT_OnTheMap
//
//  Created by Tigran Tshorokhyan on 8/27/17.
//  Copyright © 2017 Tigran Tshorokhyan. All rights reserved.
//

import UIKit
import MapKit

class AddLocationVC: UIViewController, UITextViewDelegate {

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var address: UITextView!
    
    var placeMark: CLPlacemark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.address.delegate = self
    }
    
    @IBAction func findOnTheMap(_ sender: Any) {
        let clGeoEncoder = CLGeocoder()
        clGeoEncoder.geocodeAddressString(address.text) { (placemarks, error) in
            if error == nil {
                if let placemarks = placemarks {
                    self.placeMark = placemarks[0] as CLPlacemark
                }
                self.performSegue(withIdentifier: "segueMapStudent", sender: self)
            }else {
        }
    }
 }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMapStudent" {
            let mapStudentViewController = segue.destination as! MapStudentVC
            mapStudentViewController.placeMark = placeMark
            mapStudentViewController.mapString = address.text
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
}
