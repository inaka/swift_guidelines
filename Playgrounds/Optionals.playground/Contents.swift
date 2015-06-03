import UIKit
/*:
# Optionals

One of the main selling-points of Swift is *type safety*. 

One of the most unsafe bugs we encounter is trying to access a property with the assumption that there is a value assigned, and there isn't one.

Optionals exist to add a level of safety so that one should always know if a property is allowed to be nil, or *must* always have a value.

Properties can be declared as variables (`var`) or constants (`let`). For both of these types of declarations, the property can be:

* Optional (variable)

* Required (constant)

* Optional, but *implicitly unwrapped*
*/
struct MyExampleStruct {
	var firstName : String? //Optional
	let lastName : String // Non-Optional (required. This value **must** be set in the initialization
	let apiKey : String = "x4Q7sdf" // Non-optional, but initialized during its declaration
	var gender : String! // Implicitly Unwrapped Optional
	
	init(lastname: String) {
		self.lastName = lastname
	}
	init(firstname: String?, lastname: String, gender: String!) {
		self.firstName = firstname
		self.lastName = lastname
		self.gender = gender
	}
}

/*:
note that the following init will fail, because `apiKey` is a constant (`let`) whose value has already been assigned:

	
    init(firstname: String?, lastname: String, apikey: String!, gender: String!) {
        self.firstName = firstname
        self.lastName = lastname
        self.apiKey = apikey
        self.gender = gender
	}
	
*/
var s = MyExampleStruct(lastname: "Fred")
var u = MyExampleStruct(firstname: "Howard", lastname: "Duck", gender: "M")

/*:

Where possible, strive to keep your properties safe, meaning `Optional`. Valid reasons for non-safety (*implicitly unwrapped optionals*) are:
* Instances where you are **absolutely certain** that at runtime, they will never be nil (`@IBOutlet`s are a good example of this.
* *Lazy vars* (but with caveats, discussed below).
*/
/*:
In a class with explicitly unwrapped optionals, you can get away with not providing an initializer
*/
struct PersonUnwrapped {
	var firstname : String!
	var lastname : String!
	var age : Int!
}

var unwrappedPerson = PersonUnwrapped()
println(unwrappedPerson.firstname)
//count(unwrappedPerson.firstname)

/*:
In a class with no explicitly unwrapped optionals, nor with optionals, you **must** provide an initializer
*/
struct PersonNotUnwrapped {
	var firstname : String
	var lastname : String
	var age : Int
	
	init(firstname: String, lastname: String, age: Int) {
		self.firstname = firstname
		self.lastname = lastname
		self.age = age
	}
}
let notwrappedPerson = PersonNotUnwrapped(firstname: "Fred", lastname: "Baxter", age: 33)

/*:
Of course, you can mix and match Optionals, non-optionals, and explicitly unwrapped optionals:
*/
struct PersonMixed {
	var firstname : String?
	var lastname : String
	var age : Int!
	
	
/*: Note that you only have to include non-optionals in your init */
	init(lastname: String) {
		self.lastname = lastname
	}
	
	
/*: Use Convenience inits when appropriate */
	init(firstname: String, lastname: String, age: Int) {
		self.init(lastname: lastname)
		self.firstname = firstname
		self.age = age
	}
	
	init(dictionary: Dictionary<String, AnyObject>) {
		let lastname = dictionary["lastname"] as! String //NOTE: are you SURE this dictionary key will always exist? This is a potential bug.
		self.init(lastname: lastname)
		if let firstname = dictionary["firstname"] as? String {
			self.firstname = firstname
		}
		if let age = dictionary["age"] as? Int {
			self.age = age
		}
	}
}

let person1Mixed = PersonMixed(lastname: "Baxter")
let person2Mixed = PersonMixed(firstname: "Freddy", lastname: "Baxter", age: 44)
let person3Mixed = PersonMixed(dictionary: ["firstname": "Fred2", "lastname" : "Bexter", "age" : 44])

var personArray = [person1Mixed, person2Mixed, person3Mixed]

/*:
Remember, `if let` only works with optional values
*/
if let personFirstName = person2Mixed.firstname, age = person2Mixed.age
	where age == 44 {
	println("Found \(personFirstName) is \(age)")
}

//: Filtering on non-optionals works as expected:
var baxters = personArray.filter { person in person.lastname == "Baxter" }
baxters.count

//: Filtering on non-optionals works as expected:
var firstBaxters = personArray.filter { person in person.firstname == "Freddy" }
firstBaxters

//: Filtering on explicitly unwrapped optionals does not work as expected:
//: Uncomment these lines out, as they are crashing:
//var ageBaxters = personArray.filter { person in person.age == 44 }
//ageBaxters
/*:
Especially when making API calls, it's often not possible to completely populate your object or value types with all their properties. In this case, it may be just the `id` and (perhaps) `created_at` properties can be defined as non-optional.

*/

/*: 
# Getters and Setters
There are several ways of providing custom behavior when getting or setting a property

### `didSet`

*/
struct MyProperty {
	var firstname : String
	var lastname : String? {
		didSet {
			println("Setting job description")
			self.jobDescription = "\(self.lastname!) has a job description"
		}
	}
	var jobDescription : String?
	init(firstname: String) {
		self.firstname = firstname
	}
}
var describedPerson = MyProperty(firstname: "Fred")
describedPerson.lastname = "Baxter"
describedPerson.jobDescription

/*:
### `willSet`
*/
struct MyProperty2 {
	var firstname: String
	var lastname: String? {
		willSet {
			self.lastname = "\(newValue) is a dork!"
		}
	}
	var fullname : String?
	
	init(firstname: String) {
		self.firstname = firstname
	}
}
var person2 = MyProperty2(firstname: "Fred")
person2.lastname = "Baxter"
person2.fullname

//: Note that in both of these cases, the property being used must be unwrapped, as they are optionals. A safer way to handle this would be to check if these values are nil.

/*:
### Lazy vars
creating a property which is a computed value:
*/
struct MyThingie3 {
	let firstname: String
	let lastname: String
	lazy var fullname : String = {
		return "\(self.firstname) \(self.lastname)"
	}()
}
//: Note that without a custom initializer, you still must provide a value for all properties, even lazy ones.
var person3 = MyThingie3(firstname: "Fred", lastname: "Baxter", fullname: nil)
person3.fullname

/*:
#### CAVEAT
if you have a lazy var containing implicitly unwrapped optional values that are nil, your app **will** crash!
*/
struct MyUnsafeLazyThing {
	var firstname: String!
	var lastname: String
	
	lazy var fullname : String = {
		return "\(self.firstname) \(self.lastname)"
		}()
	
	init(firstname: String?, lastname: String) {
		self.firstname = firstname
		self.lastname = lastname
	}
}
var unsafePerson = MyUnsafeLazyThing(firstname: nil, lastname: "Baxter")
unsafePerson.fullname // doesn't crash in Playground, but trust me on this one.

var safePerson = MyUnsafeLazyThing(firstname: "Fred", lastname: "Baxter")
safePerson.fullname


/*:
### Get and Set full overrides
At times it makes sense to fully override the get/sets. This is useful when, for example, the item will be loaded and saved as a `NSUserDefault`.

In this case, create a private var to store the value, and a public var to do the object manipulation.
Note, however, that this is must less preferable to the option of leveraging 'didSet' or 'willSet'.

*/
class MyUserController {
	private var _porpoise : Porpoise?
	var porpoise : Porpoise {
		get {
			if let user = self._porpoise {
				return user
			} else if let user = Porpoise.load() {
				return user
			} else {
				return Porpoise()
			}
		}
		set {
			self._porpoise = newValue
			Porpoise.save(self._porpoise!)
		}
	}
	init() {
		self._porpoise = Porpoise.load()
	}
	struct Porpoise {
		var firstname: String!
		
		static func load() -> Porpoise? {
			if let data = NSUserDefaults.standardUserDefaults().objectForKey("SavedUser") as! NSData?, dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String : AnyObject] {
				var firstname = dict["firstname"] as! String
				var person = Porpoise(firstname: firstname)
				
				return person
			} else {
				var porpoise = Porpoise()
				porpoise.firstname = "Unknown"
				return porpoise
			}
		}
		static func save(user: Porpoise) {
			//no-op for the purposes of this demo.
		}
	}
}
var controller = MyUserController()
controller
var controllerPerson = controller.porpoise

