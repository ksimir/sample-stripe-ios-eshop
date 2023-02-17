//
//  ContentView.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/15.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject private var cart: Cart
  // Products list
  @State private var Products: [Product]?

  // Initialize the catalog by fetching products from Stripe Product API
  func initializeCatalog() {
    // Loading product list from Stripe API
    // this returns a cached product list if the backend isn't responding
    DataProvider.shared.allProducts(){productlist in
      Products = productlist
    }
  }
  
  var body: some View {
    NavigationView {
      VStack {
        // Display error message if our backend is unable to retrieve
        // Product list and no cache exists (first app opening)
        if Products == nil {
          HStack {
            ProgressView()
            Text("eShop loading...")
          }
        }else{
          // Listing all the products with image, name and price
          List(Products!, id: \.id) { product in
            HStack {
              AsyncImage(url: URL(string: product.image)) { image in
                image.resizable()
              } placeholder: {
                ProgressView()
              }
              .frame(width: 50, height: 50)
              Text(product.name)
              Spacer()
              Text(formatPrice(product.price) ?? "")
              Button {
                // action
                cart.addToCart(product)
              } label: {
                Image(systemName: "plus")
              }
            }
          }

        // Checkout button to move to the payment view
        NavigationLink (destination: CheckoutView(), label: {
          Text("Checkout")
            .foregroundColor(.white)
            .font(.headline)
            .frame(height:55)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(10)
            .multilineTextAlignment(.center)
            .padding(30)
        })

        .navigationTitle("eShop")
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            VStack {
              Text("\(cart.cartCount)")
              Image(systemName: "cart")
            }
          }
        }}
      }
    }
    .onAppear{initializeCatalog()}
    .navigationBarBackButtonHidden(true)
  }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(Cart())
  }
}
#endif
