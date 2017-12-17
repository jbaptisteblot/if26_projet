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
    
    init(id_depart:Int, id_trajet: Int, heureDepart: Date, heureArrive: Date, duration: Int) {
        self.id_depart = id_depart
        self.id_trajet = id_trajet
        self.heureDepart = heureDepart
        self.heureArrive = heureArrive
        self.duration = duration
    }
    
    func durationString() -> String {
        let hours = self.duration/3600
        let minutes = (self.duration - hours*3600)/60
        
        return (String(hours)  + "h" + String(minutes))
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
