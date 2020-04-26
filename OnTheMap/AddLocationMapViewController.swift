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

   @IBOutlet weak var mapView: MKMapView!
   @IBOutlet weak var finishButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      finishButton.layer.cornerRadius = 4.0
    }
   
   @IBAction func finishButtonTapped(_ sender: UIButton) {
      print("finish button tapped")
   }
   
}
