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

   var locations: [StudentInformation] {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      return appDelegate.locations
   }
   
   @IBOutlet weak var mapView: MKMapView!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      setupMapAnnotations()
      mapView.delegate = self
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      NotificationCenter.default.addObserver(self, selector: #selector(setupMapAnnotations), name: NSNotification.Name("locations_updated"), object: nil)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      NotificationCenter.default.removeObserver(self, name: NSNotification.Name("locations_updated"), object: nil)
   }

   @objc func setupMapAnnotations() {
      mapView.removeAnnotations(mapView.annotations)
      let annotations = locations.map { (location) -> MKPointAnnotation in
         let annotation = MKPointAnnotation()
         annotation.title = "\(location.firstName) \(location.lastName)"
         annotation.subtitle = "\(location.mediaURL)"
         annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: location.latitude)!, longitude: CLLocationDegrees(exactly: location.longitude)!)
         return annotation
      }
      mapView.addAnnotations(annotations)
   }
   
   // MARK: - MKMapViewDelegate

   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let reuseId = "pin"
      if let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView {
         pinView.annotation = annotation
         return Optional(pinView)
      } else {
         let initialPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
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
      func show(url: URL) {
         let safariVC = SFSafariViewController(url: url)
         safariVC.dismissButtonStyle = .close
         self.present(safariVC, animated: true)
      }
      
      if control == view.rightCalloutAccessoryView {
         if let toOpen = view.annotation?.subtitle! {
            if let url = URL(string: toOpen), UIApplication.shared.canOpenURL(url) {
               show(url: url)
            } else if let url = URL(string: "http://" + toOpen), UIApplication.shared.canOpenURL(url)  {
               show(url: url)
            } else {
               let alertVC = UIAlertController(title: "Invalid URL", message: "Please select a valid URL.", preferredStyle: .alert)
               alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               self.present(alertVC, animated: true, completion: nil)
            }
         }
      }
   }
}
