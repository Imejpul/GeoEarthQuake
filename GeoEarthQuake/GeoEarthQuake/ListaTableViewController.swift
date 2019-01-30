//
//  ListaTableViewController.swift
//  GeoEarthQuake
//
//  Created by user148117 on 30/01/2019.
//  Copyright © 2019 Imejpul. All rights reserved.
//

import UIKit
import CodableGeoJSON
import Alamofire

class ListaTableViewController: UITableViewController {
    
    let urlHora = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
    
    var listaTerremotos = ["a", "b", "c"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //descarga GeoJSON Terremotos (todos) de la última hora
        Alamofire.request(urlHora)
            .responseData { response in
                if let data = response.data {
                    
                    //aquí entra el CodableGeoJSON / SwiftyJSON
                    
                    /*//propiedades terremoto
                    struct LocationProperties: Codable {
                        let magnitud: Decimal
                        let place: String
                        let time: Int64
                        let titulo: String
                    }
                    
                    typealias LocationFeatureCollection = GeoJSONFeatureCollection<PointGeometry, LocationProperties>;<#type expression#>
                    
                    let locationFeatures = try JSONDecoder().decode(LocationFeatureCollection.self, from: data)
                    let firstFeature = locationFeatures.features.first
                    firstFeature?.geometry.longitude
                    firstFeature?.geometry.latitude
                    firstFeature?.geometry.depth*/
                    
                }
            
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaTerremotos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaTerremoto", for: indexPath) as! EarthQuakeTableViewCell
        
            cell.tituloTerremoto.text = listaTerremotos[indexPath.row]

        // Configure the cell...

        return cell
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
