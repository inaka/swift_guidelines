import Foundation

public struct Person {
	public var name : String
	public var age : Int
	public var birthday : NSDate
	
	public init(name: String, age: Int, birthday: NSDate) {
		self.name = name
		self.age = age
		self.birthday = birthday
	}
}