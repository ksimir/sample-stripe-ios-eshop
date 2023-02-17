//
//  Cart.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/15.
//

import Foundation

class Cart: ObservableObject {
  
  @Published private(set) var items: [Product] = [Product]()
  
  var cartTotal: Double {
    return items.reduce(0) { result, product in
      result + product.price
    }
  }
  
  var cartCount: Int {
    items.count
  }
  
  func addToCart(_ item: Product) {
    items.append(item)
  }

  func emptyCart(){
    items.removeAll()
  }
}
