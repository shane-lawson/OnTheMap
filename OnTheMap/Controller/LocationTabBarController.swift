//
//  LocationTabBarController.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit

class LocationTabBarController: UITabBarController {

   var appDelegate: AppDelegate {
      return UIApplication.shared.delegate as! AppDelegate
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()

      refreshAnnotations()
   }
    
   @IBAction func refresh(_ sender: UIBarButtonItem) {
      refreshAnnotations()
   }
   
   @IBAction func logout(_ sender: UIBarButtonItem) {
      UdacityAPI.logout { (success, error) in
         guard success else { print(error!); return }
         DispatchQueue.main.async {
            self.appDelegate.locations.removeAll()
            self.performSegue(withIdentifier: "logoutSuccess", sender: self)
         }
      }
   }
 
   fileprivate func refreshAnnotations() {
      UdacityAPI.getStudentLocations(completionHandler: storeStudentLocations(locations:error:))
   }
   
   fileprivate func storeStudentLocations(locations: [StudentInformation], error: Error?) {
      DispatchQueue.main.async { [unowned self] in
         guard error == nil else {
            let alertVC = UIAlertController(title: "Download error", message: "Could not download locations. Please try again leter.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            return
         }
         self.appDelegate.locations.removeAll()
         locations.forEach {
            self.appDelegate.locations.append($0)
         }
         NotificationCenter.default.post(name: NSNotification.Name("locations_updated"), object: nil)
      }
   }
}
