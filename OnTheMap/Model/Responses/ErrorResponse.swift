//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/28/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct ErrorResponse: LocalizedError, Codable {
   let status: Int
   let error: String

   var errorDescription: String? {
      return error
   }
}
