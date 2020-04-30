//
//  User.swift
//  ForestAdventures
//
//  Created by Jerry haaser on 4/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let password: String
}
