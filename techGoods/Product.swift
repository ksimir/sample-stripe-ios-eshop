//
//  Product.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/15.
//

import Foundation

struct Product: Codable {
  var id: String
  var name: String
  var price: Double
  var image: String
  var category: String
}

extension Product {

  static func temp() -> [Product] {

    return [
      Product(id:UUID().uuidString, name: "iPhone", price: 100000, image: "phone", category: "Electronics"),
      Product(id:UUID().uuidString, name: "MacBook", price: 130000,image: "pc", category: "Electronics"),
      Product(id:UUID().uuidString, name: "iPad", price: 50000, image: "tablet", category: "Electronics"),
    ]
  }
}
