/*:
# MVVM

[Code taken from http://rasic.info/bindings-generics-swift-and-mvvm/](http://rasic.info/bindings-generics-swift-and-mvvm/)
*/

import UIKit
import SwiftTutorialLib

/*:
### Bindable class using Generics

Because `didSet` is never called in initialization, `bindAndFire` needs to be defined for when the viewModel is assigned.
*/

class Dynamic<T> {
	typealias Listener = T -> Void
	var listener : Listener?
	
	var value : T {
		didSet {
			self.listener?(value)
		}
	}
	
	init(_ val: T) {
		self.value = val
	}
	
	func bind(listener: Listener?) {
		self.listener = listener
	}
	
	func bindAndFire(listener: Listener?) {
		self.listener = listener
		self.listener?(value)
	}
}

protocol PersonViewModel {
	var firstName: Dynamic<String> { get }
	var lastName: Dynamic<String> { get }
	var gender: Dynamic<String> { get }
}

class PersonViewModelFromPerson : PersonViewModel {
	let person : Person
	let firstName : Dynamic<String>
	let lastName : Dynamic<String>
	let gender : Dynamic<String>
	
	init(_ person: Person) {
		self.person = person
		self.firstName = Dynamic(person.firstName!)
		self.lastName = Dynamic(person.lastName!)
		self.gender = Dynamic(person.gender!.rawValue)
	}
}

class TestView : UIView {
	var firstNameLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
	var lastNameLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 40, width: 200, height: 40))
	var genderLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 80, width: 200, height: 40))
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(self.firstNameLabel)
		self.addSubview(self.lastNameLabel)
		self.addSubview(self.genderLabel)
	}
	
	var viewModel : PersonViewModel? {
		didSet {
			self.viewModel!.firstName.bindAndFire {
				[unowned self] in
				self.firstNameLabel.text = $0
			}
			self.viewModel!.lastName.bindAndFire {
				[unowned self] in
				self.lastNameLabel.text = $0
			}
			self.viewModel!.gender.bindAndFire {
				[unowned self] in
				self.genderLabel.text = $0
			}
		}
	}
}

let person = Person(firstName: "Harold", lastName: "Houdini", gender: Gender.Male)
let model = PersonViewModelFromPerson(person)
let view = TestView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.viewModel = model
view
