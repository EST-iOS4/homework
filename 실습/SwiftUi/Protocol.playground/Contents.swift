
protocol Container {
    associatedtype Item
    mutating func add(_ item: Item)
    var count: Int { get }
}

struct IntStack: Container {
    typealias Item = Int
    private var items: [Int] = []
    
    mutating func add(_ item: Int) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    public func getItems() -> [Int] {
        return items
    }
    
}

var intStack = IntStack()

intStack.add(1)
intStack.add(2)

print("IntStack count: \(intStack.count)")
print("IntStack items: \(intStack.getItems())")

struct StringStack: Container {
    typealias Item = String
    private var items: [String] = []
    
    mutating func add(_ item: String) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    public func getItems() -> [String] {
         return items
    }
}

var stringStack = StringStack()

stringStack.add("Hello")
stringStack.add("World")

print("StringStack count: \(stringStack.count)")
print("StringStack items: \(stringStack.getItems())")
