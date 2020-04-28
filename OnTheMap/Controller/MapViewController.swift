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

   var locations: [StudentLocation] {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      return appDelegate.locations
   }
   
   @IBOutlet weak var mapView: MKMapView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      setupMapAnnotations()
      mapView.delegate = self
   }
   
   func setupMapAnnotations() {
      locations.forEach {
         let annotation = MKPointAnnotation()
         annotation.title = "\($0.firstName) \($0.lastName)"
         annotation.subtitle = "\($0.mediaURL)"
         annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: $0.latitude)!, longitude: CLLocationDegrees(exactly: $0.longitude)!)
         mapView.addAnnotation(annotation)
      }
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
