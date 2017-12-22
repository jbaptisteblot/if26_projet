//
//  AddTrajetViewController.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 15/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import UIKit

class AddTrajetViewController: UIViewController, SearchPlaceControllerDelegate {
    let db:Database = Database()
    var trajet:Trajet = Trajet.init()
    @IBOutlet weak var inputTextGareDepart: UITextField!
    @IBOutlet weak var inputTextGareArrive: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func showSearchPlaceFromGareArrive(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SearchPlace") as! SearchPlaceController
        myVC.trajet = trajet
        myVC.typeSearch = "arrive"
        myVC.delegate = self
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    @IBAction func showSearchPlaceFromGareDepart(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SearchPlace") as! SearchPlaceController
        myVC.trajet = trajet
        myVC.typeSearch = "depart"
        myVC.delegate = self
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchPlaceControllerResponse(trajet: Trajet)
    {
        self.trajet = trajet
        if (trajet.gareDepart != nil) {
            inputTextGareDepart.text = trajet.gareDepart?.name
        }
        if (trajet.gareArrive != nil) {
            inputTextGareArrive.text = trajet.gareArrive?.name
        }
    }

    @IBAction func saveButtonClick(_ sender: Any) {
        if(trajet.gareArrive != nil && trajet.gareDepart != nil) {
            db.findOrInsert(trajet: trajet)
            navigationController?.popViewController(animated: true)
        }
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
