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
   
   static var getStudentLocationsResponse = """
{
"results":[
{
"createdAt": "2015-02-25T01:10:38.103Z",
"firstName": "Jarrod",
"lastName": "Parkes",
"latitude": 34.7303688,
"longitude": -86.5861037,
"mapString": "Huntsville, Alabama ",
"mediaURL": "https://www.linkedin.com/in/jarrodparkes",
"objectId": "JhOtcRkxsh",
"uniqueKey": "996618664",
"updatedAt": "2015-03-09T22:04:50.315Z"
},
{
"createdAt":"2015-02-24T22:27:14.456Z",
"firstName":"Jessica",
"lastName":"Uelmen",
"latitude":28.1461248,
"longitude":-82.756768,
"mapString":"Tarpon Springs, FL",
"mediaURL":"www.linkedin.com/in/jessicauelmen/en",
"objectId":"kj18GEaWD8",
"uniqueKey":"872458750",
"updatedAt":"2015-03-09T22:07:09.593Z"
},
{
"createdAt":"2015-02-24T22:30:54.442Z",
"firstName":"Jason",
"lastName":"Schatz",
"latitude":37.7617,
"longitude":-122.4216,
"mapString":"18th and Valencia, San Francisco, CA",
"mediaURL":"http://en.wikipedia.org/wiki/Swift_%28programming_language%29",
"objectId":"hiz0vOTmrL",
"uniqueKey":"2362758535",
"updatedAt":"2015-03-10T17:20:31.828Z"
},
{
"createdAt": "2015-02-24T22:35:30.639Z",
"firstName": "Gabrielle",
"lastName": "Miller-Messner",
"latitude": 35.1740471,
"longitude": -79.3922539,
"mapString": "Southern Pines, NC",
"mediaURL": "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
"objectId": "8ZEuHF5uX8",
"uniqueKey": "2256298598",
"updatedAt": "2015-03-09T22:06:11.615Z"
}
]
}
"""
   
   static var postStudentLocationResponse = """
{
    "createdAt":"2015-03-11T02:48:18.321Z",
    "objectId":"CDHfAy8sdp"
}
"""
   
   static var putStudentLocationResponse = """
{
    "updatedAt":"2015-03-11T02:56:49.997Z"
}
"""
   
   static var postSessionResponse = """
{
"account":{
"registered":true,
"key":"3903878747"
},
"session":{
"id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
"expiration":"2015-05-10T16:48:30.760460Z"
}
}
"""
   
   static var deleteSessionResponse = """
{
"session": {
"id": "1463940997_7b474542a32efb8096ab58ced0b748fe",
"expiration": "2015-07-22T18:16:37.881210Z"
}
}
"""
   
}
