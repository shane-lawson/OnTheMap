//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/24/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class MapViewController: UIViewController, MKMapViewDelegate {

   @IBOutlet weak var mapView: MKMapView!
   
   var annotations: [MKPointAnnotation] {
      let firstPoint = MKPointAnnotation()
      firstPoint.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 50.44)!, longitude: CLLocationDegrees(exactly: -89.25)!)
      firstPoint.title = "Some point"
      firstPoint.subtitle = "http://google.com"
      let secondPoint = MKPointAnnotation()
      secondPoint.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 40.44)!, longitude: CLLocationDegrees(exactly: -99.25)!)
      secondPoint.title = "Some other point"
      secondPoint.subtitle = "http://udacity.com"
      return [firstPoint, secondPoint]
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      
      mapView.addAnnotations(annotations)
      mapView.delegate = self
   }

   // MARK: - MKMapViewDelegate

   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let reuseId = "pin"
      if let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView {
         pinView.annotation = annotation
         return Optional(pinView)
      } else {
         let initialPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
         initialPinView.animatesDrop = true
         initialPinView.pinTintColor = #colorLiteral(red: 0.1648017168, green: 0.7030932307, blue: 0.895126164, alpha: 1)
         initialPinView.canShowCallout = true
         let button = UIButton(type: .detailDisclosure)
         button.setImage(UIImage(systemName: "safari"), for: .normal)
         initialPinView.rightCalloutAccessoryView = button
         return Optional(initialPinView)
      }
   }
   
   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      // open url in safari view controller
      if control == view.rightCalloutAccessoryView {
         if let toOpen = view.annotation?.subtitle! {
            let safariVC = SFSafariViewController(url: URL(string: toOpen)!)
            safariVC.dismissButtonStyle = .close
            self.present(safariVC, animated: true)
         }
      }
   }
}

