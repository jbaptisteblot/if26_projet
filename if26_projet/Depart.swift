//
//  Depart.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 16/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import Foundation

class Depart{
    var id_depart: Int
    var id_trajet: Int
    var heureDepart: Date
    var heureArrive: Date
    var duration: Int
    let dateFormatter = DateFormatter()
    let dateFormatterHour = DateFormatter()
    
    init(id_depart:Int, id_trajet: Int, heureDepart: Date, heureArrive: Date, duration: Int) {
        self.id_depart = id_depart
        self.id_trajet = id_trajet
        self.heureDepart = heureDepart
        self.heureArrive = heureArrive
        self.duration = duration
        
        dateFormatter.dateFormat = "yyyyMMdd'T'kkmmss"
        dateFormatterHour.dateFormat = "kk'h'mm"
    }
    
    init(id_depart:Int, id_trajet: Int, heureDepart: String, heureArrive: String, duration: Int) {
        dateFormatter.dateFormat = "yyyyMMdd'T'kkmmss"
        dateFormatterHour.dateFormat = "kk'h'mm"
        
        self.id_depart = id_depart
        self.id_trajet = id_trajet
        self.heureDepart = dateFormatter.date(from: heureDepart)!
        self.heureArrive = dateFormatter.date(from: heureArrive)!
        self.duration = duration
    }
    
    init(id_trajet: Int, heureDepart: String, heureArrive: String, duration: Int) {
        dateFormatter.dateFormat = "yyyyMMdd'T'kkmmss"
        dateFormatterHour.dateFormat = "kk'h'mm"

        self.id_depart = -1
        self.id_trajet = id_trajet
        self.heureDepart = dateFormatter.date(from: heureDepart)!
        self.heureArrive = dateFormatter.date(from: heureArrive)!
        self.duration = duration
    }
    
    func durationString() -> String {
        let hours = self.duration/3600
        let minutes = (self.duration - hours*3600)/60
        
        return (String(hours)  + "h" + String(minutes))
    }
    func heureArriveHours() -> String {
        return dateFormatterHour.string(from: self.heureArrive)
    }
    func heureDepartHours() -> String {
        return dateFormatterHour.string(from: self.heureDepart)
    }
    func heureArriveString() -> String {
        return dateFormatter.string(from: self.heureArrive)
    }
    func heureDepartString() -> String {
        return dateFormatter.string(from: self.heureDepart)
    }
    func heureDepartPlusOneString() -> String {
        let heureDepartPlusOne = self.heureDepart.addingTimeInterval(60)
        return dateFormatter.string(from: heureDepartPlusOne)
    }
}
struct DepartGlobalJsonData : Codable {
    let journeys : [DepartJson]
}
struct DepartJson : Codable {
    let departure_date_time: String
    let arrival_date_time: String
    let duration: Int
}
