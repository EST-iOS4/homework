//
//  ContentView.swift
//  Shopping
//
//  Created by 송영민 on 8/8/25.
//

import SwiftUI

struct Product: Identifiable {
  let id = UUID()
  let name: String
  let price: Double
  let imageName: String
}

struct CartItem: Identifiable {
  let id = UUID()
  let product: Product
  var quantity: Int
}

class ShoppingCartViewModel: ObservableObject {
  @Published var products: [Product] = [
    Product(name: "맥북 프로", price: 2_500_000, imageName: "laptopcomputer"),
    Product(name: "아이폰 16", price: 1_200_000, imageName: "laptopcomputer"),
    Product(name: "에어팟", price: 300000, imageName: "laptopcomputer"),
    Product(name: "애플 워치", price: 500000, imageName: "laptopcomputer"),
  ]

  @Published var cartItems: [CartItem] = []

  var totalPrice: Double {
    cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
  }

  func addTocart(_ product: Product) {
    if let index = cartItems.firstIndex(where: { $0.product.id == product.id })
    {
      cartItems[index].quantity += 1
    } else {
      cartItems.append(CartItem(product: product, quantity: 1))
    }
  }

  func removeFromCart(_ item: CartItem) {
    cartItems.removeAll { $0.id == item.id }
  }

  func updateQuantity(for item: CartItem, quantity: Int) {
    if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
      if quantity <= 0 {
        cartItems.remove(at: index)
      } else {
        cartItems[index].quantity = quantity
      }
    }
  }
}

struct ShoppingView: View {
  @StateObject private var cart = ShoppingCartViewModel()
  @State private var showingCart = false
  
  var body: some View {
    NavigationView {
      List(cart.products) { product in
        ProductRow(product: product, cart: cart)
      }
      .navigationTitle("상품 목록")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showingCart = true
          } label: {
            HStack {
              Image(systemName: "cart")
              if cart.cartItems.count > 0 {
                Text("\(cart.cartItems.count)")
                  .font(.caption)
                  .foregroundColor(.white)
                  .background(Circle().fill(Color.red).frame(width: 20, height: 20))
              }
            }
          }
        }
      }
      .sheet(isPresented: $showingCart) {
        CartView(cart: cart)
      }
    }
  }
}

struct ProductRow: View {
  let product: Product
  @ObservedObject var cart: ShoppingCartViewModel
  
  var body: some View {
    HStack {
      Image(systemName: product.imageName)
        .font(.largeTitle)
        .frame(width: 60, height: 60)
        .foregroundColor(.blue)
      
      VStack(alignment: .leading) {
        Text(product.name)
          .font(.headline)
        Text("\(Int(product.price))원")
          .foregroundColor(.secondary)
      }
      Spacer()
      
      Button {
        cart.addTocart(product)
      } label: {
        Image(systemName: "plus.circle.fill")
          .font(.title2)
      }
    }
    .padding(.vertical, 8)
  }
}

struct CartView: View {
  @ObservedObject var cart: ShoppingCartViewModel
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      if cart.cartItems.isEmpty {
        ContentUnavailableView(
          "카트가 비어있습니다",
          systemImage: "cart",
          description: Text("상품을 추가해주세요")
        )
      }else {
        List {
          ForEach(cart.cartItems) { item in
            CartItemRow(item: item, cart: cart)
          }
          .onDelete{ indexSet in
            cart.cartItems.remove(atOffsets: indexSet)
          }
          Section {
            HStack {
              Text("총 금액")
                .font(.headline)
              Spacer()
              Text("\(Int(cart.totalPrice))원")
                .font(.title2)
                .fontWeight(.bold)
            }
          }
        }
        .navigationTitle("장바구니")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("닫기") {
              dismiss()
            }
          }
        }
      }
    }
  }
}

struct CartItemRow: View {
  let item: CartItem
  @ObservedObject var cart: ShoppingCartViewModel
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(item.product.name)
          .font(.headline)
        Text("\(Int(item.product.price))원")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      Spacer()
      
      HStack {
        Button {
          cart.updateQuantity(for: item, quantity: item.quantity - 1)
        } label: {
          Image(systemName: "minus.circle")
        }
        
        Text("\(item.quantity)")
          .frame(minWidth: 30)
        
        Button {
          cart.updateQuantity(for: item, quantity: item.quantity + 1)
        } label: {
          Image(systemName: "puls.circle")
        }
        
      }
    }
  }

}



#Preview {
  ShoppingView()
}

