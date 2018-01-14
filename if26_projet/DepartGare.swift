//
//  DepartGare.swift
//  if26_projet
//
//  Created by Alexis Comte on 13/01/2018.
//  Copyright © 2018 Jean-baptiste Blot. All rights reserved.
//

import Foundation

class DepartGare {
    var idDepart: Int
    var idGareDepart: String
    var nomDestination: String
    var heureDepart: Date
    let dateFormatter = DateFormatter()
    let dateFormatterHour = DateFormatter()
    
    init(idDepart:Int, idGareDepart: String, nomGareArrivee: String, heureDepart: Date) {
        dateFormatter.dateFormat = "yyyyMMdd'T'kkmmss"
        dateFormatterHour.dateFormat = "kk'h'mm"
        
        self.idDepart = idDepart
        self.idGareDepart = idGareDepart
        self.nomDestination = nomGareArrivee
        self.heureDepart = heureDepart
    }
    
    init(idDepart: Int, idGareDepart: String, nomGareArrivee: String, heureDepart: String) {
        dateFormatter.dateFormat = "yyyyMMdd'T'kkmmss"
        dateFormatterHour.dateFormat = "kk'h'mm"
        
        self.idDepart = idDepart
        self.idGareDepart = idGareDepart
        self.nomDestination = nomGareArrivee
        self.heureDepart = dateFormatter.date(from: heureDepart)!
    }
    
    init(idGareDepart: String, nomGareArrivee: String, heureDepart: String) {
        dateFormatter.dateFormat = "yyyyMMdd'T'kkmmss"
        dateFormatterHour.dateFormat = "kk'h'mm"
        
        self.idDepart = -1
        self.idGareDepart = idGareDepart
        self.nomDestination = nomGareArrivee
        self.heureDepart = dateFormatter.date(from: heureDepart)!
    }
    
    func heureDepartHours() -> String {
        return dateFormatterHour.string(from: self.heureDepart)
    }
    
    func heureDepartString() -> String {
        return dateFormatter.string(from: self.heureDepart)
    }
    
    func heureDepartPlusOneString() -> String {
        let heureDepartPlusOne = self.heureDepart.addingTimeInterval(60)
        return dateFormatter.string(from: heureDepartPlusOne)
    }
}

struct DepartGareCollectionJson : Codable {
    let departures : [DepartGareJson]
}

struct DepartGareJson : Codable {
    let route: DepartGareRouteJson
    let stop_date_time: DepartGareDateTimeJson
}

struct DepartGareRouteJson : Codable {
    let direction: DepartGareDirectionJson
}

struct DepartGareDirectionJson : Codable {
    let name: String
    let id: String
}

struct DepartGareDateTimeJson : Codable {
    let departure_date_time: String
}

