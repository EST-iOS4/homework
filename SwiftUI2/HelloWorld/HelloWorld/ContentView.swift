//
// slider 해보기
//  ContentView.swift
//  HelloWorld
//
//  Created by 송영민 on 8/4/25.
//
//@,$ 중요 //

import SwiftUI

struct ContentView: View {
//  @State private var email: String = ""
//  @State private var username: String = ""
//  @State private var password: String = ""
//  @State private var confirmPassword: String = ""
  @State private var selectedColor: Color = .blue
  @State private var date: Date = Date()
  
  var body: some View {
    VStack {
      ColorPicker(selection: $selectedColor) {
        Text("Select a color")
          .foregroundStyle(.primary)
      }
      
      DatePicker (
        "Select a date",
        selection: $date,
        displayedComponents: [.date, .hourAndMinute]
      )
      .datePickerStyle(.wheel)
    }
    .padding()
  }
 /* var body: some View {
    VStack {
      Text("로그인")
        .font(.largeTitle)
        .padding()
      
      TextField("이메일", text: $email)
        .keyboardType(.emailAddress)
        .submitLabel(.next)
        .autocapitalization(.none)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
      
      TextField("사용자 이름을 입력하세요", text: $username)
        .padding()
        .autocapitalization(.none) //텍스트 필드 자동 대문자 변환을 방지
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
      
       SecureField("비밀번호를 입력하세요", text: $password)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
      
       SecureField("비밀번호를 재입력하세요", text: $confirmPassword)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
      
      Button(action: {
        if password != confirmPassword {
          print("비밀번호가 일치하지 않습니다.")
          return
        }
        print("사용자 이메일: \(email)사용자 이름: \(username), 비밀번호: \(password)")
      }) {
        Text("로그인")
          .frame(minWidth: 0, maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundStyle(.white)
          .cornerRadius(8)
      }
    }
    .padding()
  } */
}
  
#Preview {
  ContentView()
}
