//
//  RoomMain.swift
//  ForestAdventures
//
//  Created by Brandi Bailey on 5/1/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

struct RoomMain: Codable {
    var num_rooms: Int
    var rooms: [Room]
}

struct Room: Codable {
    var id: Int
    var name: String
    var description: String
    var n_to: Int?
    var s_to: Int?
    var e_to: Int?
    var w_to: Int?
    var x: Int
    var y: Int
    var item: String?
}
