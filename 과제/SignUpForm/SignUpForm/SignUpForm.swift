//
//  ContentView.swift
//  SignUpForm
//
//  Created by 송영민 on 8/7/25.
//

import SwiftUI

struct SignUpForm: View {
  @State private var username = ""
  @State private var email = ""
  @State private var password = ""
  @State private var confirmPassword = ""
  @State private var birthYear = 2000
  @State private var agreeToTerms = false
  @State private var receiveNewsletter = false
  @State private var showAlert = false
  
  
    var body: some View {
        NavigationView {
          Form {
            Section(header: Text("계정 정보")) {
              TextField("사용자명", text: $username)
                .autocapitalization(.none)
              
              TextField("E-mail", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
              
              SecureField("비밀번호", text: $password)
              
              SecureField("비밀번호 확인", text: $confirmPassword)
            }
            Section(header: Text("개인 정보")) {
              Stepper(value: $birthYear, in: 1900...2024) {
                HStack {
                  Text("생년월일")
                  Text("\(birthYear)")
                    .foregroundColor(.blue)
                }
              }
            }
            Section(header: Text("약관 동의")) {
              Toggle("이용약관에 동의합니다.", isOn: $agreeToTerms)
              
              Toggle("뉴스레터 수신 동의", isOn: $receiveNewsletter)
            }
            
            Section {
              Button(action: signUp) {
                Text("가입하기")
                  .frame(maxWidth: .infinity)
                  .foregroundColor(.white)
              }
              .listRowBackground(
                isFormValid ? Color.blue : Color.gray
              )
              .disabled(!isFormValid)
            }
          }
          .navigationTitle("회원가입")
          .alert("가입 완료", isPresented: $showAlert) {
            Button("확인") {}
          } message: {
            Text("회원가입이 완료되었습니다!")
          }
      }
    }
  var isFormValid: Bool {
    !username.isEmpty &&
    !email.isEmpty &&
    !password.isEmpty &&
    password == confirmPassword &&
    agreeToTerms
  }
  func signUp() {
    showAlert = true
  }
}

#Preview {
    SignUpForm()
}
  