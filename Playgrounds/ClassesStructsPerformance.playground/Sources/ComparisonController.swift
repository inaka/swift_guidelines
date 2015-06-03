import Foundation
import XCPlayground

public class ComparisonController {
	public var allClasses = [TutorialClass]()
	public var allStructs = [TutorialStruct]()
	
	public init(){}
	
	public func createAllClasses(number: Int) {
		for var i=0;i<number;i++ {
			var cls = TutorialClass(firstVariable: i)
			self.allClasses.append(cls)
		}
	}
	
	public func createAllStructs(iterations: Int) {
		for var i=0;i<iterations;i++ {
			var struc = TutorialStruct(firstVariable: i)
			self.allStructs.append(struc)
		}
	}
	
	public func mutateAllClasses() {
		for cls in self.allClasses {
			cls.firstVariable += 1
		}
	}
	public func mutateClassesByCreatingNewClasses() {
		var localClasses = [TutorialClass]()
		for c in self.allClasses {
			var tutClass = TutorialClass(firstVariable: c.firstVariable+1)
			localClasses.append(tutClass)
		}
		self.allClasses = localClasses
	}
	
	 public  func mutateAllStructs() {
		var localStructs = [TutorialStruct]()
		for struc in self.allStructs {
			var tutStruct = TutorialStruct(firstVariable: struc.firstVariable+1)
			localStructs.append(tutStruct)
		}
		self.allStructs = localStructs
	}
}
