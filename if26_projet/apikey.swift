//
//  apikey.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 14/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import Foundation

class APIKEY {
    static var SNCF: String {
        set {
            let defaults = UserDefaults.standard
                defaults.set(newValue, forKey: "sncfapikey")
        }
        get {
            let defaults = UserDefaults.standard
            if let apikeysncf = defaults.string(forKey: "sncfapikey") {
                
                return apikeysncf
            } else {
                return ""
            }
        }
    }
}
