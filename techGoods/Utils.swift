//
//  Utils.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/15.
//

import Foundation

func formatPrice(_ price: Double) -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter.string(from: NSNumber(value: price/100))
}
