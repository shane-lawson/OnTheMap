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
   
   var annotations: [MKPointAnnotation] = TestData.annotations
   var studentLocations = [StudentLocation]()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      
      updateLocations()
      mapView.delegate = self
   }

   fileprivate func updateLocations() {
      UdacityAPI.getStudentLocations { [unowned self] (locations, error) in
         locations.forEach { (location) in
            let annotation = MKPointAnnotation()
            annotation.title = "\(location.firstName) \(location.lastName)"
            annotation.subtitle = "\(location.mediaURL)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: location.latitude)!, longitude: CLLocationDegrees(exactly: location.longitude)!)
            self.mapView.addAnnotation(annotation)
         }
      }
   }
   
   @IBAction func refreshLocations(_ sender: UIBarButtonItem) {
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
