//
//  SessionResponses.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import Foundation

struct SessionPOSTResponse: Codable {
   let account: Account
   let session: Session
}

struct SessionDELETEResponse: Codable {
   let session: Session
}
