import Foundation

let fibonacciArray: Array<Int> = [1, 1, 2, 3, 5, 8, 13, 21, 34]
let fibonacciSet: Set<Int> = [1, 1, 2, 3, 5, 8, 13, 21, 34] // 회원가입에서 중복 확인

print(fibonacciArray.count)
print(fibonacciSet.count)

print(fibonacciArray.contains(3))


var animals: Set<String> = ["cat", "dog", "mouse", "elephant"]
animals.insert("rabbit")
print(animals.contains("dog"))
animals.remove("dog")
print(animals.contains("dog"))

let evenNumbers = Set<Int>(arrayLiteral: 2, 4, 6, 8, 10)
let oddNumbers: Set<Int> = [1, 3, 5, 7, 9]
let squareNumbers: Set<Int> = [1, 4, 9]
let triangularNumbers: Set<Int> = [1, 3, 6, 10]

let evenOrTriangularNumbers = evenNumbers.union(triangularNumbers).union(triangularNumbers)
print(evenOrTriangularNumbers.count)

let oddAndSquareNumbers = oddNumbers.intersection(squareNumbers)
print(oddAndSquareNumbers.count)

let squareOrTriangularNotBoth = squareNumbers.symmetricDifference(triangularNumbers)
print(squareOrTriangularNotBoth.count)

let squareNotOdd = squareNumbers.subtracting(oddNumbers)
print(squareNotOdd.count)
