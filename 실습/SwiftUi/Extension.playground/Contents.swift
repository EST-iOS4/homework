import Foundation

extension String {
    func firstWord() -> String {
        let spaceIndex = firstIndex(of: " ") ?? endIndex
        let word = prefix(upTo: spaceIndex)
        return String(word)
    }
}
let sentence = "The quick brown fox jumps over the lazy dog"

let firstWord = sentence.firstWord()
let prefix = sentence.prefix(5)

print("First word: \(firstWord)") // First word: the
print("Prefix: \(prefix)")  // Prefix : the

protocol IntRepresntable {
    var intValue: Int { get }
}

extension Int: IntRepresntable {
    var intValue: Int {
        return self
    }
}

extension Double: IntRepresntable {
    var intValue: Int {
        return Int(self)
    }
}

extension String: IntRepresntable {
    var intValue: Int {
      return Int(self) ?? 0
    }
}

let stringValue: String = "425"
print("String value as Int: \(stringValue.intValue)") // String value as Int: 42

enum CrewComplement: Int {
    case enterprise = 1014
    case voyager = 150
    case deepSpaceNine = 2000
}

extension CrewComplement: IntRepresntable {
    var intValue: Int {
        return self.rawValue
    }
}

let voyagerCrew = CrewComplement.voyager
print("Voyager crew complement: \(voyagerCrew.intValue)") // Voyager crew complement: 150


enum CoinFlip: Int {
    case heads
    case tails
    
    func description() -> String {
        switch self {
        case .heads:
            return "Heads"
        case .tails:
            return "Tails"
        }
    }
    
    
    static func flip() -> CoinFlip {
        //return CoinFlip(rawValue: Int(arc4random_uniform(2)))!
        return CoinFlip(rawValue: Int.random(in: 0...1)) ?? .heads
    }
}

let coinFlip = CoinFlip.flip()
let coinFlipDescription = coinFlip.description()
print(CoinFlip(rawValue: 0)!.description())


