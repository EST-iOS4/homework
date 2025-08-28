//
//  ProgrammaticNavigation.swift
//  ListNavigation
//
//  Created by 송영민 on 8/7/25.
//

import SwiftUI

struct ProgrammaticNavigation: View {
  @State private var path = NavigationPath()

  var body: some View {
    NavigationStack(path: $path) {
      VStack(spacing: 20) {
        Button("숫자 화면으로 이동") {
          path.append(42)
        }

        Button("텍스트 화면으로 이동") {
          path.append("Hello")
        }
      }
      .navigationDestination(for: Int.self) {
        number in DetailView(path: $path, number: number)
      }
      .navigationDestination(for: String.self) {
        text in TextDetailView(text: text)
      }
      .navigationTitle("홈")
    }
  }

  struct DetailView: View {
    @Binding var path: NavigationPath
    var number: Int
    
    var body: some View {
      Text("숫자 상세화면 \(number)")
        .font(.largeTitle)
        .padding()
      
      Button("숫자 상세 화면으로 이동") {
        path.append(Int.random(in: 1...100))
      }
      
      Button("뒤로 가기") {
        path.removeLast() //뒤로가기
      }
      
      Button("홈으로 이동") {
        path.removeLast(path.count)
      }
    }
  }

  struct TextDetailView: View {
    var text: String

    var body: some View {
      Text("텍스트 상세화면: \(text)")
        .font(.largeTitle)
        .padding()
    }
  }

}

#Preview {
  ProgrammaticNavigation()
}

//    var body: some View {
//      NavigationStack {
//        List {
//          NavigationLink("상세 화면으로", destination: DetailView())
//        }
//        .navigationTitle("내 사람들")
//      }
//    }
//}
//
//
//struct DetailView: View {
//  var body: some View {
//    Text("상세화면")
//      .font(.largeTitle)
//      .padding()
//  }
//}
