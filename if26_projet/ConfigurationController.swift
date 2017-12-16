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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
