import UIKit
import XCPlayground
import SwiftTutorialLib
/*:
# Learning Swift
## Maintaining State

*/
/*:
### State is a thorny issue, no matter what programming language you're using.

There should be only one source of **truth** for any given [collection] of items, whether they be `classes` or `structs`.
*/
StateManager.manager.people.count
var kid = Person(firstName: "Fred", lastName: "Baxter", gender: Gender.Male)
//Person(name: "Fred Baxter", age: 34, birthday: NSDate())
StateManager.manager.people.append(kid)
StateManager.manager.people.count
StateManager.manager.people.removeAtIndex(0)
StateManager.manager.people.count

//: There has to be a better way to add and remove Persons from this array!

//: You can make an `Array extension` to find the index of the item you're looking for:
extension Array {
	func indexOf<T: Equatable>(x:T) -> Int? {
		for i in 0...self.count-1 {
			if self[i] as! T == x {
				return i
			}
		}
		return nil
	}
}

StateManager.manager.people.append(kid)
//var kidIndex = StateManager.manager.people.indexOf(kid) // This won't work

//: Note that the item you're looking for must override `==` and declare it to conform to the `Equatable` protocol.
extension Person : Equatable {}
public func ==(lhs: Person, rhs: Person) -> Bool {
	return (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName)
}

var kidIndex = StateManager.manager.people.indexOf(kid) // This works!
var theKidOnTheBlock = Person(firstName: "Ginger", lastName: "Rogers", gender: Gender.Male)
var anIndex = StateManager.manager.people.indexOf(theKidOnTheBlock) // returns nil because theKidOnTheBlock isn't in the people array.
StateManager.manager.people.append(theKidOnTheBlock)
var theIndex = StateManager.manager.people.indexOf(theKidOnTheBlock)

