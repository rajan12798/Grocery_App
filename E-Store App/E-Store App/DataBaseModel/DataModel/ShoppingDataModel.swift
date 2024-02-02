//
//  ShoppingDataModel.swift
//  E-Store App
//
//  Created by rajan kumar on 26/01/24.
//

import Foundation
import SwiftData
import SwiftUI
@Model class ShoppingDataModel: Codable {
    var categories: [Category]
    var startdate: Date
    init(categories: [Category],
         startDate: Date = .now) {
           self.categories = categories
        self.startdate = startDate
       }
    private enum CodingKeys: String, CodingKey {
        case categories
    }
    required init(from decoder:Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decode([Category].self, forKey: .categories)
        startdate = .now
        }
    public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(categories, forKey: .categories)
       }

}

//// MARK: - Category
@Model
final class Category: Codable {
    let id: Int
    let name: String
    let items: [CategoriesItem]
    init(id: Int, name: String, items: [CategoriesItem]) {
            self.id = id
            self.name = name
            self.items = items
        }
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case items
    }
    init(from decoder:Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        items = try values.decode([CategoriesItem].self, forKey: .items)
    }
    public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(id, forKey: .id)
           try container.encode(name, forKey: .name)
           try container.encode(items, forKey: .items)
        
       }
}
//
//// MARK: - Item
@Model
final class CategoriesItem: Codable {
    @Attribute(.unique) let id: Int
    let name: String
    let icon: String
    let price: Double
    var isLike: Bool = false
    init(id: Int, name: String, icon: String, price: Double) {
        self.id = id
        self.name = name
        self.icon = icon
        self.price = price
    }
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case icon
        case price
    }
    init(from decoder:Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        icon = try values.decode(String.self, forKey: .icon)
        price = try values.decode(Double.self, forKey: .price)
    }
    public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(id, forKey: .id)
           try container.encode(name, forKey: .name)
           try container.encode(icon, forKey: .icon)
           try container.encode(price, forKey: .price)
       }
}
