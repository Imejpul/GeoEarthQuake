//
//  ListaTableViewController.swift
//  GeoEarthQuake
//
//  Created by user148117 on 30/01/2019.
//  Copyright © 2019 Imejpul. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListaTableViewController: UITableViewController {
    
    let urlHora = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
    
    struct Terremoto {
        var magnitud: Decimal
        var sitio: String
        var fechaHora: Int64
        var titulo: String
        var longitud: Decimal
        var latitud: Decimal
        var profundidad: Decimal
    }
    
    var listaTerremotosTest = ["a", "b", "c"]
    /*var terremotos = [Terremoto(magnitud: <#T##Decimal#>, sitio: <#T##String#>, fechaHora: <#T##Int64#>, titulo: <#T##String#>, longitud: <#T##Decimal#>, latitud: <#T##Decimal#>, profundidad: <#T##Decimal#>)]*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Alamofire.request(urlHora, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                //recorremos el json
                print("JSON: \(json)")
                print("---------------------")
                
                let features = json["features"].count
                
                for valor in 0..<features{
                    //controlar que no sea null -> json["features"][valor]["properties"]["place"]
                   
                    let place = json["features"][valor]["properties"]["place"]
                    print(valor)
                    print(place)
                    
                    
                }
                //asignamos valores a struct y guardamos en lista
                
                /*testeo
                print("JSON: \(json)")
                print("--------------")
                print(json[][0]["properties"]["place"])
                print(json["features"].count)
                //print(json["features"][indexPath.row]["properties"]["place"])
                */
            case .failure(let error):
                print(error)
            }
        }
        
        /*//descarga GeoJSON Terremotos (todos) de la última hora
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
            
        }*/
        

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
        return listaTerremotosTest.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaTerremoto", for: indexPath) as! EarthQuakeTableViewCell
        
            cell.tituloTerremoto.text = listaTerremotosTest[indexPath.row]

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
