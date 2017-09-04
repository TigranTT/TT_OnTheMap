//
//  OnTheMap.swift
//  TT_OnTheMap
//
//  Created by Tigran Tshorokhyan on 8/27/17.
//  Copyright © 2017 Tigran Tshorokhyan. All rights reserved.
//

import Foundation

struct OnTheMap {
    let account: [String: AnyObject]
    
    
    init(_ dictionary: [String: AnyObject]) {
        account = dictionary[OnTheMapClient.JSONResponseKeys.account] as! [String : AnyObject]
    }
    
    func getUserId() -> String {
        return (account[OnTheMapClient.JSONResponseKeys.userId] as? String)!
    }
    
}
