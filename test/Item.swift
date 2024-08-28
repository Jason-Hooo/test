//
//  Item.swift
//  test
//
//  Created by 何杰陞 on 2024/8/28.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
