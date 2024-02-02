//
//  Item.swift
//  E-Store App
//
//  Created by rajan kumar on 26/01/24.
//

import Foundation
import SwiftData

@Model
final class cartItem {
    var Item: CategoriesItem
    var addTime: Date
    var qty: Int
    init(item: CategoriesItem, addTime: Date = .now, Qty: Int) {
        self.Item = item
        self.addTime = addTime
        self.qty = Qty
    }
}
