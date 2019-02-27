//
//  MapaViewController.swift
//  GeoEarthQuake
//
//  Created by  on 20/2/19.
//  Copyright © 2019 Imejpul. All rights reserved.
//

import UIKit
import MapKit




class MapaViewController: UIViewController {    
    
    var terremotos = [Terremoto]()
    
    var initialLocation : CLLocation!
    
    var regionRadius : CLLocationDistance!
    
    @IBOutlet weak var mapView: MKMapView!
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        cargarDatos()
        
        // Centrar el mapa
        if terremotos.count > 1{
            initialLocation = CLLocation(latitude: terremotos[0].latitud, longitude: terremotos[0].longitud)
            regionRadius = 8000000
            
        } else {
            regionRadius = 2000000
            initialLocation = CLLocation(latitude: terremotos[0].latitud, longitude: terremotos[0].longitud)
        }
        centerMapOnLocation(location: initialLocation)
    }
    
    @objc func cargarDatos(){
    
        // REF: https://stackoverflow.com/a/32850454/5136913
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        for e in terremotos {
            let anotacion = Anotacion(terremoto: e)
            self.mapView.addAnnotation(anotacion)
            
        }
    }

}



class Anotacion: NSObject, MKAnnotation {
    
    var title: String? // MKAnnotation
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D // MKAnnotation
    let fecha: String
    var color: UIColor!
    
    init(terremoto e: Terremoto) {
        
        //Info del terremoto
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "dd/MM/yyyy HH:mm"
        
        if(e.titulo != "?") {
            self.title = "\(e.titulo) \(e.profundidad) Km depth"
        } else {
            self.title = "\(e.sitio) \(e.magnitud) ML"
        }
        
        self.coordinate = CLLocationCoordinate2D(latitude: e.latitud, longitude: e.longitud)
        self.fecha = dateFmt.string(from: e.fechaHora)
        self.subtitle = "\(self.fecha)"
        
        if e.magnitud >= 5{
            self.color = UIColor.red
        } else if (e.magnitud < 5) && (e.magnitud >= 3){
            self.color = UIColor.orange
        } else if (e.magnitud < 3){
            self.color = UIColor.gray
        }
        
        super.init()
    }
    
}

extension UIViewController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Anotacion else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
        }
        
        view.markerTintColor = annotation.color
        
        return view
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
}
