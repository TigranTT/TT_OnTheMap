//
//  LoginTextField.swift
//  TT_OnTheMap
//
//  Created by Tigran Tshorokhyan on 9/4/17.
//  Copyright © 2017 Tigran Tshorokhyan. All rights reserved.
//

import UIKit

class LoginTextField: UITextField, UITextFieldDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
