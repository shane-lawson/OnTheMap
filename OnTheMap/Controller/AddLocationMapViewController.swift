//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/25/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController {

   var placemark: CLPlacemark!
   
   @IBOutlet weak var mapView: MKMapView!
   @IBOutlet weak var finishButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      finishButton.layer.cornerRadius = 4.0
      let annotation = MKPointAnnotation()
      annotation.coordinate = placemark.location!.coordinate
      annotation.title = placemark.name
      mapView.addAnnotation(annotation)
      mapView.centerCoordinate = annotation.coordinate
      mapView.delegate = self
    }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      mapView.setRegion(MKCoordinateRegion(center: placemark.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
   }
   
   @IBAction func finishButtonTapped(_ sender: UIButton) {
      print("finish button tapped")
   }
   
}
