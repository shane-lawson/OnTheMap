//
//  StudentLocationResponses.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct StudentLocationPOSTResponse: Codable {
   let createdAt: String
   let objectId: String
}

struct StudentLocationPUTResponse: Codable {
   let updatedAt: String
}

struct StudentLocationGETResponse: Codable {
   let results: [StudentInformation]
}
