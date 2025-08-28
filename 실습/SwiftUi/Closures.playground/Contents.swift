import Foundation

func add(a: Int, b: Int) -> Int {
    return a + b
}

let addClosure: (Int, Int) -> Int = { a, b in
    return a + b
}

print(add(a: 3, b: 5))
print(addClosure(3, 5))


let number = [1, 2, 3, 4, 5]
let doubledNumber = number.map { $0 * 2 }
let doubledNumber2 = number.map { numberElement in
return numberElement * 2}

print(doubledNumber)
print(doubledNumber2)

// 짝수만 필터링
let evenNumbers = number.filter { $0 % 2 == 0 }

// 5보다 작은 수만 필터링
let smallNumbers = number.filter { number in
    return number < 5
}

print(evenNumbers)
print(smallNumbers)

//모든 수의 합

let sum = number.reduce(0) {
    result, number in
    return result + number
}

let sum2 = number.reduce(0) { $0 + $1 }
let sum3 = number.reduce(0, +)

print(sum)
print(sum2)
print(sum3)


let twoDemensionalArray = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

let sum2DArray = twoDemensionalArray.map { row in
    return row.reduce(0) { $0 + $1 }
}

let totalSum2DArray = sum2DArray.reduce(0) { $0 + $1 }


print(sum2DArray)
print(totalSum2DArray)

print("\n===== 클로저의 캡처 ======")

func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

let counter = makeCounter( )
print("첫 번째 호출: \(counter())") // 1
print("두 번째 호출: \(counter())") // 2
print("세 번째 호출: \(counter())") // 3

