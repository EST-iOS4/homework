//
//  ContentView.swift
//  Calculator
//
//  Created by 송영민 on 8/5/25.
//

import SwiftUI

struct ContentView: View {
  @State private var formulaString = ""
  @State private var resultString = ""

  var body: some View {
    Text(formulaString)
      .padding(20)
      .font(.system(size: 55))
      .foregroundStyle(.secondary)
      .frame(maxWidth: .infinity, alignment: .trailing)

    Text(resultString)
      .padding(20)
      .font(.system(size: 80))
      .frame(maxWidth: .infinity, alignment: .trailing)

    HStack(alignment: .top) {
      VStack(spacing: 10) {
        Button {
        } label: {
          HStack {
            Text("M")
            VStack {
              Text("R")
                .font(.caption2)
              Text("C")
                .font(.caption2)
            }
          }
          .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("7")
        } label: {
          Text("7")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("4")
        } label: {
          Text("4")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("1")
        } label: {
          Text("1")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("0")
        } label: {
          Text("0")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
      }

      VStack(spacing: 10) {
        Button {
        } label: {
          Text("M-")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("8")
        } label: {
          Text("8")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("5")
        } label: {
          Text("5")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("2")
        } label: {
          Text("2")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("00")
        } label: {
          Text("00")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
      }

      VStack(spacing: 10) {
        Button {
        } label: {
          Text("M+")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("9")
        } label: {
          Text("9")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("6")
        } label: {
          Text("6")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("3")
        } label: {
          Text("3")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula(".")
        } label: {
          Text(".")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
      }

      VStack(spacing: 10) {
        Button {
        } label: {
          Text("+/-")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
        } label: {
          Text("%")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("×")
        } label: {
          Text("×")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("+")
        } label: {
          Text("+")
            .frame(width: 50, height: 125)
        }
        .buttonStyle(.bordered)
      }

      VStack(spacing: 10) {
        Button {
          formulaString = ""
          resultString = "0"
        } label: {
          Text("CE/C")
            .font(.system(size: 22))
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("√")
        } label: {
          Text("√")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("÷")
        } label: {
          Text("÷")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("-")
        } label: {
          Text("-")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
        Button {
          calculateResult()
          formulaString = ""
          formulaString = resultString
        } label: {
          Text("=")
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.bordered)
      }
    }
    .font(.largeTitle)
    .padding()
  }

  private func appendToFormula(_ value: String) {
    if let lastCharacter = formulaString.last,
      "+−×÷".contains(lastCharacter) && "+−×÷".contains(value)
    {
      formulaString.removeLast()
    }
    formulaString += value
  }

  private func calculateResult() {

    let numbers = formulaString.components(
      separatedBy: CharacterSet(charactersIn: "+−×÷")
    )
    print("Numbers: \(numbers)")
    let operators = formulaString.filter { "+−×÷".contains($0) }
    print("Operatiors: \(operators)")
    
    var result = Int(numbers[0]) ?? 0

    for i in 0..<operators.count {
      let op = operators[operators.index(operators.startIndex, offsetBy: i)]

      switch op {
      case "+":
        result += Int(numbers[i + 1])!
      case "−":
        result -= Int(numbers[i + 1])!
      case "×":
        result *= Int(numbers[i + 1])!
      case "÷":
        if numbers[i + 1] != "0" {
          result /= Int(numbers[i + 1])!
        }else {
          resultString = "Error"
          return
        }
        
      default:
        print("잘못된 Operatiors입력")
        break
      }
    }
    //소수점 없는 경우 출력
    

    resultString = String(result)
  }
}

#Preview {
  ContentView()
}
