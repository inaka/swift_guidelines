//: Playground - noun: a place where people can play

import UIKit

/*:
### Simple switching on an `int`
*/
let val = 10
switch val {
case 1: println("One")
case 10: println("Ten")
default: println("Some other number")
}

/*:
### Switching on an int using ranges
*/
switch val {
case 0...9: println("It's a single digit")
case 10...99: println("We've got double-digits")
case 100...999: println("Whoa, triple-digit number")
default: println("There are 4 or more digits here")
}

/*:
### Switching on Enums
*/

enum Result {
	case Value(Int)
	case Error(String)
}

let result = Result.Value(1)
switch result {
case let .Value(val):
	println("Success! The value is \(val)")
case .Error(let err):
	println("Error! And here's the error: \(err)")
}

/*:
### Switching on Tuples
*/
let person = ("Fred", 39)
switch person {
case ("Fred", let age):
	println("Person is Fred, whose age is \(age) years")
case (_, 39):
	println("Person is 39 years old")
case (_, 20...29):
	println("Person is in their twenties")
case (let name, _):
	println("Person's name is \(name), who is not in their twenties")
case (_, _):
	println("I couldn't be bothered checking on the name or age")
}
/*:
#### Switching on Tuples while binding the case statements
*/
let personage = ("Edward Malthus", 55)
switch personage {
case let (name, age) where age > 55:
	println("Personage is \(name) whose age is \(age)")
case (let name, let age):
	println("This is another way to get \(name) and \(age)")
case (_, let age):
	println("I couldn't care less about the name, but I know now that their age is \(age)")
}
/*:
### Switching on types
*/

var button : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
button.setTitle("Click me", forState: UIControlState.Normal)
//: Unfortunately, cannot add target/action to playgrounds (yet?)
//button.addTarget(self, action: "respondToInput:", forControlEvents: UIControlEvents.TouchUpInside)

func respondToInput(sender : AnyObject?) {
	switch sender {
	case is UIButton:
		println("Selection is a button")
	case let label as UILabel:
		println("Selection is a label with this text: \(label.text)")
	case let tableView as UITableView:
		println("It's a Table View with \(tableView.numberOfSections()) sections")
	default:
		println("Sender is neither a button, a label, or a tableView")
	}
}

respondToInput(button)

