//
//  ContentView.swift
//  AsyncAwait
//
//  Created by 송영민 on 8/8/25.
//

import SwiftUI

func fetchUserdata() async throws -> String {
  try await Task.sleep(nanoseconds: 1_000_000_000)
  if Bool.random() {
    throw URLError(.badServerResponse)
  }
  return "User Data"
}

struct ContentView: View {
  @State private var isLoading: Bool = true
  @State private var userData: String = "Loading..."
  @State private var errorMessage: String?

  var body: some View {
    VStack {
      if isLoading {
        ProgressView("Loading..")
          .padding()
      } else if let errorMessage = errorMessage {
        Text("Error: \(errorMessage)")
          .foregroundColor(.red)
          .padding()
      } else {
        Text(userData)
          .font(.title)
          .padding()
      }
      Button("Fetch Data") {
        Task {
          do {
            isLoading = true
            errorMessage = nil
            userData = try await fetchUserdata()
          } catch {
            errorMessage = error.localizedDescription
          }
          isLoading = false
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
