//
//  InfoEarthQuakeViewController.swift
//  GeoEarthQuake
//
//  Created by user148117 on 30/01/2019.
//  Copyright © 2019 Imejpul. All rights reserved.
//

import UIKit

class InfoEarthQuakeViewController: UIViewController {

    @IBOutlet weak var mag: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var coordinates: UILabel!
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var depth: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    var terremoto : Terremoto!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mag.text = "Mag: " + String(terremoto.magnitud) + " ML"
        place.text = "Place: " + terremoto.sitio
        time.text = "Date: " + convertirFechaA_String(fecha_origen: terremoto.fechaHora)
        coordinates.text = "Coordinates: "
        
        long.text = "Long: " + String(terremoto.longitud)
        lat.text = "Lat: " + String(terremoto.latitud)
        depth.text = "Depth: " + String(terremoto.profundidad) + " Kms"
        duration.text = ""
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarMapaTerremoto" {
            let destino = segue.destination as! MapaViewController;
            destino.terremotos.removeAll()
            destino.terremotos.append(terremoto)
            
        }
    }
    
    private func convertirFechaA_String(fecha_origen: Date) -> String{
        var fechaConvertida = ""
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateStyle = DateFormatter.Style.short
        
        dateformatter.timeStyle = DateFormatter.Style.short
        
        fechaConvertida = dateformatter.string(from: fecha_origen)
        
        return fechaConvertida
    }

}
