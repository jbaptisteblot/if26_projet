//
//  DepartTableViewController.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 17/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import UIKit

class DepartTableViewController: UITableViewController {
    let database: Database = Database()
    let dateFormatter = DateFormatter()
    let dateFormatterHour = DateFormatter()
    
    var trajet:Trajet = Trajet()
    var departList:[Depart] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let listDepartDB = database.selectDepart(id_trajet: trajet.id_trajet!)
        var latestDepart:Depart? = nil
        if(listDepartDB.count > 0) {
            for departdb in listDepartDB {
                if(departdb.heureDepart < Date()) {
                    database.deleteDepart(id_trajet: departdb.id_depart)
                }
                else if (latestDepart == nil || departdb.heureDepart > latestDepart!.heureDepart) {
                    latestDepart = departdb
                }
            }
        }
        if (listDepartDB.count < 5) {
            if (latestDepart == nil) {
                searchData(minDate: nil)
            } else {
                searchData(minDate: latestDepart!.heureDepartPlusOneString())
            }
        }
        else {
            departList = listDepartDB
        }
        

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
        var urlStr = "https://api.sncf.com/v1/coverage/sncf/journeys?to=" + trajet.gareArrive!.id + "&from=" + trajet.gareDepart!.id + "&min_nb_journeys=5"
        if (minDate != nil) {
            urlStr += "&datime=" + minDate!
        }
        let url = URL(string: urlStr)
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization" : APIKEY.SNCF]
        let session = URLSession.init(configuration : config)
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    self.departList.removeAll()
                    
                    
                    let journeysJSON = try! decoder.decode(DepartGlobalJsonData.self, from: data)
                    for journeyJSON in journeysJSON.journeys {
                        print(journeyJSON)
                        //self.gareList.append(Gare.init(id: gareJSON.id, name: gareJSON.name))
                        self.database.insertDepart(depart: Depart(id_trajet: self.trajet.id_trajet!, heureDepart: journeyJSON.departure_date_time, heureArrive: journeyJSON.arrival_date_time, duration: journeyJSON.duration))
                    }
                    self.departList = self.database.selectDepart(id_trajet: self.trajet.id_trajet!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            }.resume()
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departCell", for: indexPath)

        cell.textLabel?.text = departList[indexPath.row].heureDepartHours() + " -> " + departList[indexPath.row].heureArriveHours()
        cell.detailTextLabel?.text = departList[indexPath.row].durationString()

        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (self.trajet.gareDepart?.name)! + " vers " + (self.trajet.gareArrive?.name)!
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
