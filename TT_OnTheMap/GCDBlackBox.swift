//
//  GCDBlackBox.swift
//  TT_OnTheMap
//
//  Created by Tigran Tshorokhyan on 8/27/17.
//  Copyright © 2017 Tigran Tshorokhyan. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
