//
//  ConfigurationController.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 14/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import UIKit

class ConfigurationController: UIViewController {
    @IBOutlet weak var SNCFApikeyInput: UITextField!
    @IBOutlet weak var APILabel: UILabel!
    @IBOutlet weak var RAZLabel1: UILabel!
    @IBOutlet weak var RAZLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APILabel.text = "Afin de pouvoir accéder aux données en ligne de la SNCF, il est nécessaire d'utiliser une clé d'API développeur, à renseigner ici :"
        RAZLabel1.text = "Cette fonction permet de créer ou recréer les tables de la base de données, lors de la première utilisation de l'application sur un nouvel appareil ou en cas de problème avec les tables."
        RAZLabel2.text = "Attention : Ceci supprimera toutes les données enregistrées."
        APILabel.sizeToFit()
        RAZLabel1.sizeToFit()
        RAZLabel2.sizeToFit()
        
        SNCFApikeyInput.insertText(APIKEY.SNCF)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveButtonClicked(_ sender: Any) {
        APIKEY.SNCF = SNCFApikeyInput.text!
    }
    @IBAction func CreateTableSQLITE(_ sender: Any) {
        Database().createTable()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
