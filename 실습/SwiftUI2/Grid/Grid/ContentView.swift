//
//  ContentView.swift
//  Grid
//
//  Created by 송영민 on 8/7/25.
//

import SwiftUI

struct ContentView: View {
  let rows = [
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
    GridItem(.fixed(100))
    ]
  
  let adaptiveColumns = [
    GridItem(.adaptive(minimum: 100))
  ]
  
  let mixedColumns = [
    GridItem(.fixed(100)),
    GridItem(.flexible()),
    GridItem(.adaptive(minimum: 50)),
    
  ]
    var body: some View {
      ScrollView(.horizontal) {
        LazyHGrid(rows: rows, spacing: 20) {
          ForEach(0..<30) { index in
            Rectangle()
              .fill(Color.black)
              .frame(width: 100)
              .overlay(
                Text("\(index)")
                  .foregroundStyle(.white)
                  .font(.headline)
              )
          }
        }
        
      }
      
        ScrollView {
          LazyVGrid(columns: rows, spacing: 20) {
            ForEach(0..<30) { index in
              Rectangle()
                .fill(Color.blue)
                .frame(height: 100)
                .overlay(
                  Text("\(index)")
                    .foregroundStyle(.white)
                    .font(.headline)
                )
            }
            
          }
          
          LazyVGrid(columns: adaptiveColumns, spacing: 20) {
            ForEach(0..<30) { index in
              Rectangle()
                .fill(Color.red)
                .frame(height: 100)
                .overlay(
                  Text("\(index)")
                    .foregroundStyle(.white)
                    .font(.headline)
                )
            }
            
          }
          
          LazyVGrid(columns: mixedColumns, spacing: 20) {
            ForEach(0..<30) { index in
              Rectangle()
                .fill(Color.green)
                .frame(height: 100)
                .overlay(
                  Text("\(index)")
                    .foregroundStyle(.white)
                    .font(.headline)
                )
            }
            
          }
          
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
