//
//  Confirmation.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/15.
//

import SwiftUI

struct ConfirmationView: View {
  var amountPaid: String
  var paymentIntentID: String
  
  var body: some View {
    VStack {
      Spacer()
      HStack {
        Image(systemName: "checkmark.circle.fill").foregroundColor(.white)
        Text("Your order is confirmed!")
          .foregroundColor(.white)
          .font(.system(size: 30))
      }
      Spacer()
      Text(amountPaid)
        .foregroundColor(.white)
        .font(.system(size: 20))
      Text("Your payment intent ID is:")
        .foregroundColor(.white)
        .font(.system(size: 20))
      Text(paymentIntentID)
        .foregroundColor(.white)
        .font(.system(size: 20))
      Spacer()
    } .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.green)

    NavigationLink(destination: ContentView().environmentObject(Cart())) {
        Text("Back to the shop")
    }.font(.system(size: 20))


      .navigationBarBackButtonHidden(true)
  }
}

struct Confirmation_Previews: PreviewProvider {
  static var previews: some View {
    var amountPaid: String = "Total $1000"
    var paymentIntentID: String = "pi_3Mc87HEHzOAoF2zW1dhq3J70"
    ConfirmationView(amountPaid: amountPaid, paymentIntentID: paymentIntentID)
  }
}
