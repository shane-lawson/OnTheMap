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

      // Do any additional setup after loading the view.
      refreshAnnotations()
   }
    
   @IBAction func refresh(_ sender: UIBarButtonItem) {
      refreshAnnotations()
   }
   
   @IBAction func logout(_ sender: UIBarButtonItem) {
      
   }
 
   fileprivate func refreshAnnotations() {
      UdacityAPI.getStudentLocations(completionHandler: storeStudentLocations(locations:error:))
   }
   
   fileprivate func storeStudentLocations(locations: [StudentLocation], error: Error?) {
      locations.forEach {
         appDelegate.locations.append($0)
      }
   }
}
