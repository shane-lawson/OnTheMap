//
//  Session.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct Session: Codable {
   let id: String
   let expiration: String
}

struct Account: Codable {
   let registered: Bool
   let key: String
}
