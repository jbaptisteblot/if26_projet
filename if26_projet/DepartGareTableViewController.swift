//
//  DepartGareFavTableViewController.swift
//  if26_projet
//
//  Created by Alexis Comte on 12/01/2018.
//  Copyright © 2018 Jean-baptiste Blot. All rights reserved.
//

import UIKit

class DepartGareTableViewController: UITableViewController {
    let database: Database = Database()
    let dateFormatter = DateFormatter()
    let dateFormatterHour = DateFormatter()
    
    var gare:Gare = Gare(id: "", name: "")
    var departList:[DepartGare] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let listeDepartDB = database.selectDepartGare(idGare: gare.id)
        var latestDepart:DepartGare? = nil
        // Vérification des départs encore à venir
        if (listeDepartDB.count	> 0) {
            for departDB in listeDepartDB {
                if(departDB.heureDepart < Date()) {
                    database.deleteDepartGare(idGare: departDB.idGareDepart)
                } else if (latestDepart == nil || departDB.heureDepart > latestDepart!.heureDepart) {
                    latestDepart = departDB
                }
            }
        }
        // S'il n'y a plus assez de départs en base de données
        if (listeDepartDB.count < 5) {
            searchData(minDate: nil)
        } else {
            departList = listeDepartDB
        }
        
        // TODO Finir cette partie
        // Implémenter l'utilisation de mindate.
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return departList.count
    }
    
    func searchData(minDate: String?) {
        // Création de l'URL de requête
        let url = URL(string: "https://api.sncf.com/v1/coverage/sncf/stop_areas/" + gare.id + "/departures?data_freshness=realtime")
        
        // Configuration de la requête à l'API
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization" : APIKEY.SNCF]
        let session = URLSession.init(configuration : config)
        
        // Exloitation des données
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    self.departList.removeAll()
                    
                    let departuresJSON = try! decoder.decode(DepartGareCollectionJson.self, from: data)
                    for departureJSON in departuresJSON.departures {
                        print(departureJSON)
                        self.database.insertDepartGare(depart: DepartGare(
                            idGareDepart: self.gare.id,
                            nomGareArrivee: departureJSON.route.direction.name,
                            heureDepart: departureJSON.stop_date_time.departure_date_time
                            )
                        )
                    }
                    self.departList = self.database.selectDepartGare(idGare: self.gare.id)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departCell", for: indexPath)
        
        cell.textLabel?.text = departList[indexPath.row].nomDestination
        cell.detailTextLabel?.text = departList[indexPath.row].heureDepartHours()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Départs depuis " + (self.gare.name)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
