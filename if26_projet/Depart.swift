//
//  Depart.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 16/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import Foundation

class Depart{
    var id_depart: String
    var id_trajet: String
    var heureDepart: Date
    var heureArrive: Date
    var duration: Int
    
    init(id_depart:String, id_trajet: String, heureDepart: Date, heureArrive: Date, duration: Int) {
        self.id_depart = id_depart
        self.id_trajet = id_trajet
        self.heureDepart = heureDepart
        self.heureArrive = heureArrive
        self.duration = duration
    }
}
