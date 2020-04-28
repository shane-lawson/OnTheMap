//
//  User.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/28/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct User: Codable {
   let uniqueKey: String
   let firstName: String
   let lastName: String
   
   enum CodingKeys: String, CodingKey {
      case uniqueKey = "key"
      case firstName = "first_name"
      case lastName = "last_name"
   }
}
