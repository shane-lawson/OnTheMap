//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

class UdacityAPI {
   struct Auth {
      static var session: Session!
   }
   
   enum Endpoints: String {
      case studentLocation = "https://onthemap-api.udacity.com/v1/StudentLocation"
      case session = "https://onthemap-api.udacity.com/v1/session"
      
      var url: URL {
         return URL(string: self.rawValue)!
      }
   }
   
   class func getStudentLocations(completionHandler: @escaping ([StudentLocation], Error?) -> Void) {
      do{
         let responseObject = try JSONDecoder().decode(StudentLocationGETResponse.self, from: TestData.getStudentLocationsResponse.data(using: .utf8)!)
         completionHandler(responseObject.results, nil)
      } catch {
         completionHandler([], error)
      }
   }
   
   class func login(username: String, password: String, completionHandler: @escaping (Bool,Error?) -> Void) {
      let udacityLogin = UdacityLoginObject(username: username, password: password)
      let loginRequest = LoginRequest(udacity: udacityLogin)
      var request = URLRequest(url: Endpoints.session.url)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      do {
         request.httpBody = try JSONEncoder().encode(loginRequest)
      } catch {
         completionHandler(false, error)
      }
      URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
         guard let data = data else { completionHandler(false, error); return }
         let newData = data.subdata(in: 5..<data.count)
         do {
            let responseObject = try JSONDecoder().decode(SessionPOSTResponse.self, from: newData)
            Auth.session = responseObject.session
            completionHandler(true, nil)
         } catch {
            completionHandler(false, error)
         }
      }).resume()
   }
}
