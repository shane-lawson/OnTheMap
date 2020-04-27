//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct UdacityAPI {
   enum Endpoints: String {
      case studentLocation = "https://onthemap-api.udacity.com/v1/StudentLocation"
      case session = "https://onthemap-api.udacity.com/v1/session"
   }
   
   static func getStudentLocations(completionHandler: @escaping ([StudentLocation], Error?) -> Void) {
      do{
         let responseObject = try JSONDecoder().decode(StudentLocationGETResponse.self, from: TestData.getStudentLocationsResponse.data(using: .utf8)!)
         completionHandler(responseObject.results, nil)
      } catch {
         completionHandler([], error)
      }
   }
}


//{
//"udacity":
//   {
//      "username": "account@domain.com",
//      "password": "********"
//   }
//}
