//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
   let createdAt: String
   let firstName: String
   let lastName: String
   let latitude: Float
   let longitude: Float
   let mapString: String
   let mediaURL: String
   let objectId: String
   let uniqueKey: String
   let updatedAt: String
}
