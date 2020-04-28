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
      static var session: Session?
      static var account: Account?
      static var user: User?
      
      static func logout() {
         self.session = nil
         self.account = nil
         self.user = nil
      }
   }
   
   enum Endpoints {
      case studentLocation
      case session
      case studentLocationGET(Int)
      case user(String)
      
      var stringValue: String {
         switch self {
         case .studentLocation:
            return "https://onthemap-api.udacity.com/v1/StudentLocation"
         case .studentLocationGET(let number):
            return Endpoints.studentLocation.stringValue + "?limit=\(number)&order=-updatedAt"
         case .session:
            return "https://onthemap-api.udacity.com/v1/session"
         case .user(let user):
            return "https://onthemap-api.udacity.com/v1/users/\(user)"
         }
      }
      
      var url: URL {
         return URL(string: self.stringValue)!
      }
   }
   
   class func getStudentLocations(completionHandler: @escaping ([StudentLocation], Error?) -> Void) {
      let request = URLRequest(url: Endpoints.studentLocationGET(100).url)
      URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
         guard let data = data else { completionHandler([], error); return }
         do{
            let responseObject = try JSONDecoder().decode(StudentLocationGETResponse.self, from: data)
            completionHandler(responseObject.results, nil)
         } catch {
            completionHandler([], error)
         }
      }).resume()
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
            Auth.account = responseObject.account
            completionHandler(true, nil)
         } catch {
            do {
               let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: newData)
               completionHandler(false, errorResponse)
            } catch {
               completionHandler(false, error)
            }
         }
      }).resume()
   }
   
   class func logout(completionHandler: @escaping (Bool,Error?) -> Void) {
      // modified course example for deleting session on Udacity API
      var request = URLRequest(url: Endpoints.session.url)
      request.httpMethod = "DELETE"
      var xsrfCookie: HTTPCookie? = nil
      let sharedCookieStorage = HTTPCookieStorage.shared
      for cookie in sharedCookieStorage.cookies! {
         if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
      }
      if let xsrfCookie = xsrfCookie {
         request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
      }
      URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
         guard error == nil else { completionHandler(false, error); return }
         Auth.logout()
         completionHandler(true, nil)
      }).resume()
   }
   
   class func getUserData(completionHandler: @escaping (Bool, Error?) -> Void) {
      let request = URLRequest(url: Endpoints.user(Auth.account!.key).url)
      URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
         guard let data = data else { completionHandler(false, error); return }
         let newData = data.subdata(in: 5..<data.count)
         do {
            let responseObject = try JSONDecoder().decode(User.self, from: newData)
            Auth.user = responseObject
            completionHandler(true, nil)
         } catch {
            completionHandler(false, error)
         }
      }).resume()
   }
   
   class func postStudentLocation(mapString: String, mediaUrl: String, latitude: Float, longitude: Float, completionHandler: @escaping (Bool, Error?) -> Void) {
      var request = URLRequest(url: Endpoints.studentLocation.url)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = "{\"uniqueKey\": \"\(Auth.user!.uniqueKey)\", \"firstName\": \"\(Auth.user!.firstName)\", \"lastName\": \"\(Auth.user!.lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaUrl)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: .utf8)
      URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
         if error == nil {
            completionHandler(true, nil)
         } else {
            completionHandler(false, error)
         }
      }).resume()
   }
}
