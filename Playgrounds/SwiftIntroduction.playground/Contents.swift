import UIKit
/*:
# Learning Swift

In many ways, coding in swift can be extremely flexible. You can just use it as if it were an alien variant of Objective-C — with a few gotchas. This is most likely the way we will be using it to start with.

However, it is important to keep in mind that with the introduction of structs and more powerful enums, projects should be approached with a different philosophy. In fact, there is only one Object in the swift runtime; everything else is structs and enums.

# Coding Strategies
## 1. Aspirational

Oy, we're talking **functional programming**. Let's revisit this in 6 months.
## 2. Ideal

Especially for Models, **structs** are preferable to **classes**. Of course, anything that depends on UIKit (such as `UIView`s and `UIViewController`s) will need to be a **class**. In general any `Controller` types should be classes, especially if they depend on **KVO** or `NSNotification`.

*Structs* will never magically have their underlying data changed from underneath you. *Structs* will never have threading issues. **Structs** are your friends. **Classes** are those friends you have that you're never sure if they will stab you in the back one day.

A **model** *stores* things. In the ideal world a **model** is a value type. A **controller** *does* things. **Classes** do things.

## 3. Pragmatic

In a pinch, use classes. In fact, make them subclasses of `NSObject`. But realize that you need to **feel guilty** for doing so, and have a solid reason for it when you are inevitably questioned about it in the pull request.

*/
/*: 

## Structs vs. Classes
Structs are *value types* and Classes are *reference types*. 

* **value types** (Structs and Enums) are inherently thread-safe, since they are always passed by value, so the underlying properties cannot be changed by a process on another thread.
* **Structs** should be considered immutable (although you can mutate their properties via the `mutating` keyword).
* **Classes** are inheritable (You can subclass a Class). 
* **Structs** are not inheritable (You cannot "subclass" a struct, although you can force a struct to conform to a protocol).
* If you need to do any **KVO** or respond to any `NSNotification`s, you must use a **class** and inherit from `NSObject`.
* In the short-term, *classes* are easier to deal with, especially when going from, say, a `UITableView` row to a Detail View and editing its value. But this is actually hiding a much bigger issue, which is the issue of **maintaining state** in an application. This will be addressed in a separate section.
*/
struct FirstStruct {
	var firstVariable : Int = 0
	var secondVariable : Int = 1
}
var firstStruct = FirstStruct()
var secondStruct = firstStruct
firstStruct.firstVariable = 4
println(firstStruct.firstVariable) // 4
println(secondStruct.firstVariable) // 0
//: ----
class FirstClass {
	var firstVariable : Int = 0
	var secondVariable : Int = 1
}
var firstClass = FirstClass()
var secondClass = firstClass
firstClass.firstVariable = 4
println(firstClass.firstVariable) // 4
println(secondClass.firstVariable) // 4
/*:
## Optionals

Optionals are perhaps the most difficult thing to get a comfortable feeling around understanding on a day-to-day basis.

One's first instinct is to create all variables as _Implicitly Unwrapped Optionals_, because those behave more or less like Objective-C variables. **This is a mistaken assumption**. One of the great values of Swift is its type safety. When you create your variables as _Implicitly Unwrapped Optionals_ without a guarantee that they will actually contain valid values, you are basically invalidating any type safety and losing the benefit of using Swift to begin with.

### Implicitly Unwrapped Optionals
Basically, think of _Implicitly Unwrapped Optionals_ (declaring a variable with "`!`") as a contract: _I guarantee that this variable will always have a value_. _Implicitly Unwrapped Optionals_ are most useful with `@IBOutlet`s, but should be avoided elsewhere if at all possible */
class FirstTutorialClass : UIView {
	@IBOutlet weak var tutorialLabel : UILabel!
}
/*:
#### warning
_implicitly unwrapped optionals_ should generally be avoided in most other cases because in using them, you are basically avoiding type safety, and risking runtime errors.

Yes, *if let* can be a pain in the ass to be typing all the time, but never be afraid of a little extra keyboard work. The goal is to have bug-free code, after all.
*/
struct OKReallyDangerous {
	var unwrapped: String!
	var optionalThingie : String?
}

var dangerous = OKReallyDangerous(unwrapped: nil, optionalThingie: "Well Hello There")
let dangerousOptional = dangerous.unwrapped
dangerousOptional.dynamicType
println(dangerous.unwrapped)
var dangerousLabel = UILabel(frame: CGRectMake(0.0, 0.0, 200, 40.0))
dangerousLabel.backgroundColor = UIColor.redColor()
dangerousLabel.text = "\(dangerous.unwrapped)"

struct NotSoDangerousAfterAll {
	var wrapped: String
	var optionalThingie: String?
}
/*: You cannot even initialize this struct without a valid `wrapped` property, so you know for sure it will be displayed correctly
`let notReallyDangerous = NotSoDangerousAfterAll(wrapped: nil, optionalThingie: "Well Hello There")`
*/
//let notReallyDangerous = NotSoDangerousAfterAll(wrapped: nil, optionalThingie: "Well Hello There")
// Uncomment the above to see.
/*: Wrapping and Unwrapping */
let nonOptionalValue = 3
nonOptionalValue.dynamicType // Swift.Int

let optionalValue : Int? = 3
optionalValue.dynamicType // Swift.Optional<Swift.Int>

let implicitlyUnwrappedValue : UILabel!
implicitlyUnwrappedValue.dynamicType // Swift.ImplicitlyUnwrappedOptions<UILabel>
//println(implicitlyUnwrappedValue.dynamicType)

let possibleNumber = "123"
let convertedNumber = possibleNumber.toInt()
convertedNumber.dynamicType

/*: ## Optional Binding 
the `if let` wording allows you to attempt to create a non-optional constant from an Optional or an Implicitly unwrapped optional value:
*/
if let whatImLookingFor = possibleNumber.toInt() {
	println("I found it: \(whatImLookingFor)")
} else {
	println("I could not find a valid integer")
}

if let whatImLookingFor = "Howdy".toInt() {
	println("I found it: \(whatImLookingFor)")
} else {
	println("I definitely didn't find an integer")
}

var boyHowdy : String!
if let testBoyHowdy = boyHowdy {
	println("found \(testBoyHowdy)")
} else {
	println("Didn't find boy howdy")
}
/*:
## Maintaining State

At some point in your application, you must retain state.
* Items returned by an API call
* Items created internally by the application
* List -> Detail views
* …

When thinking of *State*, what we're really after is a central place where we can find the **truth**. One place where we can be sure to find exactly the data we're looking for, in its freshest form. A place we can update at item in one view and in another view, to know we'll always be able to display those new updated items.

There are two ways of maintaining state which will be unique to each application being designed. Some applications will require that the data retain a cache of API calls be saved to disk with each API call. Other applications will not have that requirement, such that the data need only be kept in memory.

The maintenance of state for these two cases will require separate design strategies.

### Disk Based
When relying on disk-based cached data (whether it be using `CoreData`, `NSCoding`, or *serialized using JSON*, a **non-singleton** controller/manager class should be used to store, filter, and retrieve the data.

Each individual View Controller will be responsible for retrieving and updating its items (perhaps based on itemId or some other sort of unique identifier).

### Memory Based
While the wholesale use of `Singleton`s is discouraged, a **State Manager** singleton is a good use of this design pattern. There should be *only* one source of the **truth**, so in this case, a `Singleton` is the obvious choice for this **truth**.
*/
