//
//  TestData.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/25/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation
import MapKit

struct TestData {
   static var annotations: [MKPointAnnotation] {
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
}
