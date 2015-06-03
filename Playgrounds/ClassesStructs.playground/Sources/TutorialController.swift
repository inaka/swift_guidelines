import Foundation

public class TutorialController {
	public let firstClass : TutorialClass
	public let firstStruct : TutorialStruct
	public var secondStruct : TutorialStruct?
	
	public init() {
		self.firstClass = TutorialClass(firstVariable: 1)
		self.firstStruct = TutorialStruct(firstVariable: 1)
	}
}