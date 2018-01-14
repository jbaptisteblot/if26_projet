//
//  Gare.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 13/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import Foundation

public class Gare {
    var id: String
    var name: String
    
    init(id: String, name:String) {
        self.id = id
        self.name = name
    }
    
    public var descriptor : String {
        return "Gare(id : \(id), name : \(name))"
    }
}

struct GareGlobalJsonData : Codable {
    let places : [StopAreaJson]
}
struct StopAreaJson : Codable {
    let stop_area: GareJSON
}
struct GareJSON : Codable {
    let id: String
    let name:String
}

