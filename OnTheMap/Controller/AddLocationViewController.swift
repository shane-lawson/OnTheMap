//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/25/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {

   // MARK: Properties
   
   var placemark: CLPlacemark!

   // MARK: IBOutlets

   @IBOutlet weak var locationTextField: UITextField!
   @IBOutlet weak var urlTextField: UITextField!
   @IBOutlet weak var findLocationButton: UIButton!
   @IBOutlet weak var navBar: UINavigationItem!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
   // MARK: Overrides

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      findLocationButton.layer.cornerRadius = 4.0
    }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let viewController = segue.destination as! AddLocationMapViewController
      viewController.mediaUrl = urlTextField.text!
      viewController.placemark = self.placemark
   }
   
   // MARK: IBActions

   @IBAction func findLocationButton(_ sender: UIButton) {
      guard urlTextField.text != "" else {
         let alertVC = UIAlertController(title: "URL field is blank", message: "Please input a URL.", preferredStyle: .alert)
         alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
         present(alertVC, animated: true, completion: nil)
         return
      }
      showFindingLocation(true)
      CLGeocoder().geocodeAddressString(locationTextField.text!, completionHandler: handleForwardGeocodeAttempt(placemark:error:))
   }
   
   @IBAction func cancelButton(_ sender: UIBarButtonItem) {
      dismiss(animated: true, completion: nil)
   }
   
   // MARK: Helpers

   fileprivate func handleForwardGeocodeAttempt(placemark: [CLPlacemark]?, error: Error?) {
      guard let placemark = placemark else {
         let alertVC = UIAlertController(title: "Invalid Location", message: "Please try again.", preferredStyle: .alert)
         alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
         present(alertVC, animated: true, completion: nil)
         return
      }
      self.placemark = placemark.first
      showFindingLocation(false)
      performSegue(withIdentifier: "showMapLocation", sender: nil)
   }
   
   fileprivate func showFindingLocation(_ isFinding: Bool) {
      if isFinding {
         activityIndicator.startAnimating()
      } else {
         activityIndicator.stopAnimating()
      }
      locationTextField.isEnabled = !isFinding
      urlTextField.isEnabled = !isFinding
      findLocationButton.isEnabled = !isFinding
   }
}
