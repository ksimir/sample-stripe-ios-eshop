//
//  DataProvider.swift
//  techGoods
//
//  Created by Samir Hammoudi on 2023/02/16.
//

import Foundation

final class DataProvider {

  static let shared = DataProvider()
  var cacheKey: String = "/products"

  private init() {
    // private
  }

  // returns the product list
  func allProducts(completion: @escaping ([Product]?) -> Void) {
    let url = Constants.baseURLString.appendingPathComponent("/products")

    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
      guard
        let response = response as? HTTPURLResponse,
        response.statusCode == 200,
        let data = data
      else {
        let message = error?.localizedDescription ?? "Failed to decode response from server."
        print(message)
        completion(DataProvider.shared.retrieveProductList())
        return
      }

      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      if let productList = try? decoder.decode([Product].self, from: data){
        // if we successfully retrieve the product list from the backend, we cache the result
        self.cacheProductList(productList: productList)
        completion(productList)
      }
      else {
        print("Invalid JSON data")
        completion(nil)
      }
    })
    task.resume()
  }

  // function to cache the product list
  func cacheProductList(productList: [Product]) {
      do {
          let fileUrl = try FileManager.default
              .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
              .appendingPathComponent(cacheKey)
          let data = try JSONEncoder().encode(productList)
          try data.write(to: fileUrl)
        print("Caching successded")
      } catch {
          print("Error caching product list: \(error)")
      }
  }

  // function to retrieve the product list from the cache
  func retrieveProductList() -> [Product]? {
      do {
          let fileUrl = try FileManager.default
              .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
              .appendingPathComponent(cacheKey)
          let data = try Data(contentsOf: fileUrl)
          let productList = try JSONDecoder().decode([Product].self, from: data)
          print("Retrieved successfully from cache")
          return productList
      } catch {
          print("Error retrieving cached product list: \(error)")
          return nil
      }
  }

}
