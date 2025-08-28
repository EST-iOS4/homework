//
//  ContentView.swift
//  Shopping
//
//  Created by 송영민 on 8/7/25.
//

import SwiftUI

struct Product: Identifiable {
  let id = UUID()
  let name: String
  let price: Double
  let imageName: String
  
}

//장바구니 모델
struct CartIteam: Identifiable {
  let id = UUID()
  let product: Product
  var quantity: Int
}

// 뷰모델
class ShoppingCartViewModel: ObservableObject {
  @Published var products = [
    Product(name: "맥북프로", price: 10),
    Product(name: "아이폰로", price: 5),
    Product(name: "애플워치", price: 3)
  ]
  
  @Published var cartItems: [CartIteam] = []
  
  func addToCart(_ product: Product) {
   if let index = cartItems.firstIndex(where: { $0.product.id ==
  product.id }) {
   cartItems[index].quantity += 1
   } else {
   cartItems.append(CartItem(product: product, quantity: 1))
   }
   }

   func removeFromCart(_ item: CartItem) {
   cartItems.removeAll { $0.id == item.id }
   }
  
  
  
  
}





struct ContentView: View {
  @StateObject private var cart = ShoppingCartViewModel(
  //@State private var showingCart = false
    
  //var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
