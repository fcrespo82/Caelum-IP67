//
//  ContatosNoMapaViewController.swift
//  ContatosIP67
//
//  Created by ios7245 on 27/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit
import MapKit

class ContatosNoMapaViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    let locationManager = CLLocationManager()
    
    private var repository: ContatoRepository
    
    required init?(coder aDecoder: NSCoder) {
        self.repository = ContatoRepository.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization()
        
        let trackButton = MKUserTrackingBarButtonItem(mapView: mapa)
        
        self.navigationItem.rightBarButtonItem = trackButton
        
        self.mapa.delegate = self
    
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        for contato in repository.listaTodos() {
            mapa.addAnnotation(contato)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mapa.removeAnnotations(mapa.annotations)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var pino: MKPinAnnotationView
        
        if let annotationPin = mapa.dequeueReusableAnnotationView(withIdentifier: "pin"){
            pino = annotationPin as! MKPinAnnotationView
        } else {
            pino = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        }
        
        if let contato = annotation as? ContatoObjC {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
            imageView.image = contato.image
            
            imageView.contentMode = .scaleAspectFill
            
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.red.cgColor
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                imageView.layer.cornerRadius = imageView.bounds.height / 2
            })
            
            
            imageView.clipsToBounds = true
            
            pino.leftCalloutAccessoryView = imageView
            pino.canShowCallout = true
            pino.pinTintColor = UIColor.purple
        }
        
        return pino
    }

}
