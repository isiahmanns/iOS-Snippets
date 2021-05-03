import UIKit

var str = "Hello, playground"

class A {
    var name: String = ""
}

extension A: Equatable {
    static func == (lhs: A, rhs: A) -> Bool {
        let lshType = type(of: lhs)
        let rshType = type(of: rhs)

        if lshType == B.self && rshType == B.self {
            return (lhs as! B).isEqual(to: (rhs as! B))
        }

        if lshType == A.self && rshType == A.self {
            return lhs.isEqual(to: rhs)
        }

        return false
    }

    func isEqual(to object: A) -> Bool {
        print("comparing a")

        return name == object.name
    }
}

class B: A {
    var age: Int = 0

    func isEqual(to object: B) -> Bool {
        print("comparing b")

        return age == object.age && super.isEqual(to: object)
    }
}

let b1 = B()
b1.name = "Isiah"
b1.age = 24

let b2 = B()
b2.name = "Isiah"
b2.age = 23

// here we need to specifically overwrite != for that comparison to see subclass
//print(b1 == b2)
//print(b1 != b2)

let arr1 = [b1]
let arr2 = [b2]

// swift only sees superclass when comparing an array
// comparing individual items, swift will see subclass
print(arr1 == arr2)
