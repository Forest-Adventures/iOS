//
//  ItemModel.swift
//  ForestAdventures
//
//  Created by Jerry haaser on 4/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

struct Item: Codable {
    let name: String
    let description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
