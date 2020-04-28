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

   // MARK: Properties

   var mediaUrl: String!
   var placemark: CLPlacemark!
   
   // MARK: IBOutlets

   @IBOutlet weak var mapView: MKMapView!
   @IBOutlet weak var finishButton: UIButton!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

   // MARK: Overrides

   override func viewDidLoad() {
      super.viewDidLoad()

      finishButton.layer.cornerRadius = 4.0
      let annotation = MKPointAnnotation()
      annotation.coordinate = placemark.location!.coordinate
      annotation.title = placemark.name
      mapView.addAnnotation(annotation)
      mapView.centerCoordinate = annotation.coordinate
    }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      mapView.setRegion(MKCoordinateRegion(center: placemark.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
   }
   
   // MARK: IBActions

   @IBAction func finishButtonTapped(_ sender: UIButton) {
      activityIndicator.startAnimating()
      UdacityAPI.postStudentLocation(mapString: placemark.name!, mediaUrl: self.mediaUrl, latitude: Float(placemark.location!.coordinate.latitude), longitude: Float(placemark.location!.coordinate.longitude), completionHandler: handlePostResponse(success:error:))
   }
   
   // MARK: Helpers

   fileprivate func handlePostResponse(success: Bool, error: Error?) {
      if success {
         DispatchQueue.main.async { [unowned self] in
            self.activityIndicator.stopAnimating()
            NotificationCenter.default.post(name: NSNotification.Name("update_locations"), object: nil)
            self.dismiss(animated: true, completion: nil)
         }
      } else {
         let alertVC = UIAlertController(title: "Post failed", message: "Please try again.", preferredStyle: .alert)
         alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
         present(alertVC, animated: true, completion: nil)
      }
   }
}
