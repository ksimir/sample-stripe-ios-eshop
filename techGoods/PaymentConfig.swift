//
//  PaymentConfig.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/15.
//

import Foundation
import Stripe
import StripePaymentSheet

class PaymentConfig: ObservableObject {
  @Published var paymentSheet: PaymentSheet?
  @Published var paymentResult: PaymentSheetResult?
  @Published var paymentIntentClientSecret: String?
//  @Published var paymentIntentId: String? = ""
}

