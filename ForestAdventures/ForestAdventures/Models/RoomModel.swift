//
//  RoomModel.swift
//  ForestAdventures
//
//  Created by Jerry haaser on 4/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

struct Room: Codable {
    let name: String
    let description: String
    let item: Item?
}
