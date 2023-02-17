//
//  PaymentView.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/17.
//

import Stripe
import SwiftUI
import StripePaymentSheet

struct PaymentButtonView: View {
    var body: some View {
        HStack {
            Text("Pay").fontWeight(.bold)
        }
        .frame(minWidth: 200)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(6)
        .accessibility(identifier: "Pay button")
    }
}

struct LoadingView: View {
    var body: some View {
        if #available(iOS 14.0, *) {
            ProgressView()
        } else {
            Text("Preparing payment…")
        }
    }
}

struct PaymentStatusView: View {
    let result: PaymentSheetResult

    var body: some View {
        HStack {
            switch result {
            case .completed:
                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                Text("Your order is confirmed!")
            case .failed(let error):
                Image(systemName: "xmark.octagon.fill").foregroundColor(.red)
                Text("Payment failed: \(error.localizedDescription)")
            case .canceled:
                Image(systemName: "xmark.octagon.fill").foregroundColor(.orange)
                Text("Payment canceled.")
            }
        }
        .accessibility(identifier: "Payment status view")
    }
}
