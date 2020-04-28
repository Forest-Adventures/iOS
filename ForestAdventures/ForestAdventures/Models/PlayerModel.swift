//
//  PlayerModel.swift
//  ForestAdventures
//
//  Created by Jerry haaser on 4/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

struct Player: Codable {
    let currentRoom: Room
    let playerItems: [Item]
    
    init(currentRoom: Room, playerItems: [Item]) {
        self.currentRoom = currentRoom
        self.playerItems = playerItems
    }
}
