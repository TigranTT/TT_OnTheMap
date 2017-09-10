//
//  LoginVC.swift
//  TT_OnTheMap
//
//  Created by Tigran Tshorokhyan on 8/27/17.
//  Copyright © 2017 Tigran Tshorokhyan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLogin: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showActivityIndicator(false)
        passwordLogin.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func doneClicked() {
        view.endEditing(true)
    }
    
    @IBAction func authenticate(_ sender: Any) {
        print("Login button pressed")
        errorLogin.text = ""
        authenticate(emailLogin.text!, passwordLogin.text!)
        showActivityIndicator(true)
        doneClicked()
    }
    
    func authenticate(_ userName: String, _ password: String) {
        OnTheMapClient.sharedInstance().authenticateWithVC(self, userName, password) { (success, errorString) in
            performUIUpdatesOnMain {
                self.showActivityIndicator(true)
                if success {
                    print("login success")
                    self.completeLogin()
                    
                }else {
                    print("login failed")
                    if let errorString = errorString {
                        self.errorLogin.text = errorString
                        self.showActivityIndicator(false)
                    }
                }
            }
        }
    }
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        present(controller, animated: true, completion: nil)
    }
    
    private func showActivityIndicator (_ show: Bool = true) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
}
