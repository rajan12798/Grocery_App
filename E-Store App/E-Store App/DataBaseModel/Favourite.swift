//
//  Favourite.swift
//  E-Store App
//
//  Created by rajan kumar on 27/01/24.
//

import Foundation
import SwiftData

@Model final class Favourite{
    var addTime: Date
    var item: CategoriesItem
    
    init(addTime: Date = .now, item: CategoriesItem) {
        self.addTime = addTime
        self.item = item
    }
}
