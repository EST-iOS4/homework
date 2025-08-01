struct PersonName {
    let givenName: String
    let failyName: String
}

enum CommuicationMethod {
    case phone
    case email
    case textMessage
    case fax
    case telepathy
    case subSpaceRelay
    case tachyons
    
}



class Person {
    let name: PersonName
    let prefeffedCommunicationMethod: CommuicationMethod
    
    init(name: PersonName, commsMethod: CommuicationMethod) {
        self.name = name
        prefeffedCommunicationMethod = commsMethod
    }
    
    convenience init(givenName: String, familyName: String, commsMethod: CommuicationMethod) {
        let name = PersonName(givenName: givenName, failyName: familyName)
        self.init(name: name, commsMethod: commsMethod)
    }
    
    var displayNmae: String {
        return "\(name.givenName) \(name.failyName)"
    }
}


var crew = Dictionary<String, Person>()

crew["Captain"] = Person(givenName: "Jean-Luc", familyName: "Picard", commsMethod: .phone)
crew["First Officer"] = Person(givenName: "William", familyName: "Riker", commsMethod: .email)
crew["Shief Engineer"] = Person(givenName: "Geordi", familyName: "Laforge", commsMethod: .textMessage)
crew["Second Officer"] = Person(givenName: "Data", familyName: "Soong", commsMethod: .fax)
crew["Councillor"] = Person(givenName: "Deanna", familyName: "Troi", commsMethod: .telepathy)
crew["Security Officer"] = Person(givenName: "Tasha", familyName: "Yar", commsMethod: .subSpaceRelay)
crew["Chief Medical Officer"] = Person(givenName: "Beverly", familyName: "Crusher", commsMethod: .tachyons)

let roles = Array(crew.keys)
print(roles)

let firstRole = roles.first!
let cmo: Person = crew[firstRole]!
print("\(firstRole): \(cmo.displayNmae)")

