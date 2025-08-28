//
//  ContentView.swift
//  ProfileCard
//
//  Created by 송영민 on 8/6/25.
//

import SwiftUI

struct ProfileCard: View {
  var body: some View {
    VStack(spacing: 20) {
      //프로필 이미지
      Image(systemName: "person.circle.fill")
        .font(.system(size: 100))
        .foregroundColor(.blue)

      //이름과 직책
      VStack(spacing: 5) {
        Text("송영민")
          .font(.title)
          .fontWeight(.bold)

        Text("iOS 개발자")
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }

      //정보 섹션
      HStack(spacing: 30) {
        VStack {
          Text("42")
            .font(.title)
            .fontWeight(.semibold)
          Text("프로젝트")
            .font(.caption)
            .foregroundColor(.secondary)
        }

        VStack {
          Text("128")
            .font(.title)
            .fontWeight(.semibold)
          Text("팔로워")
            .font(.caption)
            .foregroundColor(.secondary)
        }

        VStack {
          Text("89")
            .font(.title2)
            .fontWeight(.semibold)
          Text("팔로잉")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }

      //버튼
      Button(action: {
        print("팔로우 버튼 탭")
      }) {
        Text("팔로우")
          .font(.headline)
          .foregroundColor(.white)
          .frame(width: 200, height: 50)
          .background(Color.blue)
          .cornerRadius(25)
      }
    }
    .padding()
    .background(Color.white)
    .cornerRadius(20)
    .shadow(radius: 10)
 //   .padding()
  }
}

#Preview {
  ProfileCard()
}
