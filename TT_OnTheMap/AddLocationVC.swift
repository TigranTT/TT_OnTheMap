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
    
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLogin: UITextView!
    
    var placeMark: CLPlacemark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.address.delegate = self
        activityIndicator.stopAnimating()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findOnTheMap(_ sender: Any) {
        let clGeoEncoder = CLGeocoder()
        activityIndicator.startAnimating()
        clGeoEncoder.geocodeAddressString(address.text) { (placemarks, error) in
            if error == nil {
                if let placemarks = placemarks {
                    self.placeMark = placemarks[0] as CLPlacemark
                }
                self.performSegue(withIdentifier: "segueMapStudent", sender: self)
            }else {
                self.errorLogin.text = "Address not found"
            }
            self.activityIndicator.stopAnimating()
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
