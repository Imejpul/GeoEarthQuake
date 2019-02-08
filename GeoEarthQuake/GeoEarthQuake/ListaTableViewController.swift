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
    let urlDia = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
    let urlSemana = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"
    let urlMes = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"
    
    @IBAction func boton30DiasPulsado(_ sender: UIBarButtonItem) {
    }
    @IBAction func boton7DiasPulsado(_ sender: UIBarButtonItem) {
    }
    @IBAction func botonDiaPulsado(_ sender: UIBarButtonItem) {
    }
    @IBAction func botonHoraPulsado(_ sender: UIBarButtonItem) {
    }
    
    struct Terremoto {
        var magnitud: Double
        var sitio: String
        var fechaHora: Date
        var duracion: Int
        var titulo: String
        var longitud: Double
        var latitud: Double
        var profundidad: Double
    }
    
    var listaTerremotos = [Terremoto]()

    private func cargarDatosDesdeJSON(){
        
        Alamofire.request(urlHora, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                //recorremos el json
                let features = json["features"].count
                
                for valor in 0..<features{
                    
                    let mag = json["features"][valor]["properties"]["mag"].doubleValue
                    let place = json["features"][valor]["properties"]["place"].stringValue
                    let time = json["features"][valor]["properties"]["time"].intValue
                    let updated = json["features"][valor]["properties"]["updated"].intValue - time
                    let title = json["features"][valor]["properties"]["title"].stringValue
                    let longitude = json["features"][valor]["geometry"]["coordinates"][0].doubleValue
                    let latitude = json["features"][valor]["geometry"]["coordinates"][1].doubleValue
                    let depth = json["features"][valor]["geometry"]["coordinates"][2].doubleValue
                    
                    //Tratamiento de la fecha
                    let fechaConFormato = Date(timeIntervalSince1970: Double(time/1000))
                    
                    //Creando objeto terremoto con datos descargados
                    let earthQuake = Terremoto(magnitud: mag, sitio: place, fechaHora: fechaConFormato, duracion: updated/1000, titulo: title, longitud: longitude, latitud: latitude, profundidad: depth)
                    
                    //Añadiendo objeto terremoto a la lista para ser visualizado
                    self.listaTerremotos.append(earthQuake)
                }
                
                //recarga de la tabla para visualizar los datos descargados
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarDatosDesdeJSON()

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
        
            cell.tituloTerremoto.text = listaTerremotos[indexPath.row].titulo

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
