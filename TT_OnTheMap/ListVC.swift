//
//  ListVC.swift
//  TT_OnTheMap
//
//  Created by Tigran Tshorokhyan on 8/27/17.
//  Copyright © 2017 Tigran Tshorokhyan. All rights reserved.
//

import UIKit

class ListVC: UITableViewController {
    
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocationCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell")!
        let studentLocation = StudentLocationCollection.get(atIndex: indexPath.row)
        
        cell.textLabel?.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.imageView?.image = #imageLiteral(resourceName: "icon_pin")
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocation = StudentLocationCollection.get(atIndex: indexPath.row)
        if let url = URL(string: studentLocation.mediaURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    
}
