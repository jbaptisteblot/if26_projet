//
//  Trajet.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 13/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import Foundation

public class Trajet {
    var gareDepart: Gare?
    var gareArrive: Gare?
    var id_trajet: Int?
    
    init (){
        self.gareDepart = nil
        self.gareArrive = nil
        self.id_trajet = nil
    }
    init (gareDepart : Gare) {
        self.gareDepart = gareDepart
        self.gareArrive = nil
        self.id_trajet = nil
    }
    init (gareArrive : Gare) {
        self.gareDepart = nil
        self.gareArrive = gareArrive
        self.id_trajet = nil
    }
    init (gareDepart : Gare, gareArrive : Gare) {
        self.gareDepart = gareDepart
        self.gareArrive = gareArrive
        self.id_trajet = nil
    }
    init (gareDepart : Gare, gareArrive : Gare, id_trajet: Int) {
        self.gareDepart = gareDepart
        self.gareArrive = gareArrive
        self.id_trajet = id_trajet
    }
}
