import Foundation

public  struct TutorialStruct {
	public var firstVariable : Int
	
	public init(firstVariable: Int) {
		self.firstVariable = firstVariable
	}
	
	public mutating func changeFirstVariable(newVal : Int) {
		self.firstVariable = newVal
	}
}

public func ==(lhs: TutorialStruct, rhs: TutorialStruct) -> Bool {
	return lhs.firstVariable == rhs.firstVariable
}