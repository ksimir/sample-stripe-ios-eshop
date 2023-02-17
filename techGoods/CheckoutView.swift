//
//  CheckoutView.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/15.
//

import SwiftUI
import Stripe
import StripePaymentSheet

struct CheckoutView: View {
  @ObservedObject var paymentConfig = PaymentConfig()
  @EnvironmentObject private var cart: Cart
  @State private var isSuccess: Bool = false

  // variable to pass to the confirmation view when payment was successful
  @State var paymentIntentID: String = ""
  @State var amountPaid: String = ""

  func onPaymentCompletion(result: PaymentSheetResult) {
    paymentConfig.paymentResult = result
    if case .completed = result {
      self.amountPaid = "Total \(formatPrice(cart.cartTotal) ?? "")"

      // clean the paymentsheet
      paymentConfig.paymentSheet = nil

      // payment was successful so we empty the cart
      cart.emptyCart()
      // displays the confirmation view
      DispatchQueue.main.async {
         isSuccess = true
      }
    }
  }

  // Prepares the Payment Sheet by getting the Payment Intent from the backend
  private func preparePaymentSheet() {
    let url = Constants.baseURLString.appendingPathComponent("/create-payment-intent")

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try! JSONEncoder().encode(cart.items)

    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
      guard
        let response = response as? HTTPURLResponse,
        response.statusCode == 200,
        let data = data,
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
        let clientSecret = json["clientSecret"] as? String,
        let paymentIntentId = json["paymentintentid"] as? String
      else {
        print("Failed to decode response from server.")
        return
      }

      DispatchQueue.main.async {
        paymentConfig.paymentIntentClientSecret = clientSecret
        self.paymentIntentID = paymentIntentId

        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "TechGoods, Inc."

        paymentConfig.paymentSheet = PaymentSheet(
          paymentIntentClientSecret: paymentConfig.paymentIntentClientSecret!,
          configuration: configuration)
      }

    }
    )
    task.resume()
  }

  var body: some View {
    VStack {
      List {

        ForEach(cart.items, id: \.id) { item in
          HStack {
            Text(item.name)
            Spacer()
            Text(formatPrice(item.price) ?? "")
          }
        }

        HStack {
          Spacer()
          Text("Total \(formatPrice(cart.cartTotal) ?? "")")
          Spacer()
        }
      }
      VStack{
        if let paymentSheet = paymentConfig.paymentSheet {
          PaymentSheet.PaymentButton(
            paymentSheet: paymentSheet,
            onCompletion: onPaymentCompletion

          ) {
            PaymentButtonView()
          }
        } else {
          LoadingView()
        }
        if let result = paymentConfig.paymentResult {
          PaymentStatusView(result: result)
        }
      }

      NavigationLink(isActive: $isSuccess, destination: {
        ConfirmationView(amountPaid: self.amountPaid, paymentIntentID: paymentIntentID)
      }, label: {
        EmptyView()
      })

      .navigationTitle("Checkout")
      .onAppear { preparePaymentSheet()}
    }
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CheckoutView().environmentObject(Cart())
    }
  }
}
