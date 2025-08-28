
let numbers = [1, 2, 3, 4, 5]

// 일반 클로저
let doubled = numbers.map( { $0 * 2 } )
// 후행 클로저
let doubled2 = numbers.map() { $0 * 2 }
// 후행 클로저 + 함수 괄호 생략
let doubled3 = numbers.map { $0 * 2 }

func repeatAction(times: Int, action: () -> Void) {
    for i in 1...times {
        print("실행 \(i)번째:")
        action()
    }
}

repeatAction(times: 3, action: {
    print("안녕하세요!")
})

repeatAction(times: 3) {
  print("후행 클로저로 안녕하세요!")
}
