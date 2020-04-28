//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/27/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct UdacityLoginObject: Codable {
   let username: String
   let password: String
}

struct LoginRequest: Codable {
   let udacity: UdacityLoginObject
}
