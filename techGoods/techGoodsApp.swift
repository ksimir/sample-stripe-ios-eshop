//
//  techGoodsApp.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/15.
//

import SwiftUI
import Stripe

@main
struct techGoodsApp: App {
    init() {
        StripeAPI.defaultPublishableKey = Constants.publishableKey
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Cart())
        }
    }
}
