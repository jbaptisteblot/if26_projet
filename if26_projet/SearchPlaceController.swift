//
//  SearchPlaceController.swift
//  if26_projet
//
//  Created by Jean-baptiste Blot on 14/12/2017.
//  Copyright © 2017 Jean-baptiste Blot. All rights reserved.
//

import UIKit

class SearchPlaceController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var gareList:[Gare] = [Gare.init(id: "test", name: "test")]
    @IBOutlet weak var input_NomGare: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        let url = URL(string: "https://api.sncf.com/v1/coverage/sncf/places?type[]=stop_area&q=" + input_NomGare.text!)
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization" : APIKEY.SNCF]
        let session = URLSession.init(configuration : config)
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    self.gareList.removeAll()
                    let json = try! JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                    let stopAreasJSON = try! decoder.decode(GareGlobalJsonData.self, from: data)
                    for stopAreaJSON in stopAreasJSON.places {
                        let gareJSON = stopAreaJSON.stop_area
                        self.gareList.append(Gare.init(id: gareJSON.id, name: gareJSON.name))
                    }
                    DispatchQueue.main.async {
                     self.tableView.reloadData()
                    }
                }
            }
        }.resume()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gareList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "gareCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = gareList[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: <#T##String#>)
    }
    @IBOutlet weak var tableView: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
