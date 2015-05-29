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

public typealias MeasuredBlock = ()->Void

//
// Calls a particular block the specified number of times, returning the average
// number of seconds it took to complete the code. If a name is supplied the time
// take for each iteration will be recorded
//
public func measure(name:String? = nil, iterations:Int = 10, forBlock block:MeasuredBlock)->(mean: Double, total: Double) {
	precondition(iterations > 0, "Iterations must be a positive integer")
	
	var total : Double = 0
	var samples = [Double]()
	let start = NSDate.timeIntervalSinceReferenceDate()
	
	for i in 0..<iterations{
		
		block()
		let took = Double(NSDate.timeIntervalSinceReferenceDate() - start)
		
		if let name = name {
			XCPCaptureValue(name, took)
		}
		
		samples.append(took)
		
		total += took
	}
	let totalTook = Double(NSDate.timeIntervalSinceReferenceDate() - start)
	if let name = name {
		println("Total: \(totalTook)")
		XCPCaptureValue(name, totalTook)
	}
	
	let mean = total / Double(iterations)
	
	if let name = name {
		
		var deviation = 0.0
		
		for result in samples {
			
			let difference = result - mean
			
			deviation += difference*difference
		}
		
		let variance = deviation / Double(iterations)
		
		let formatter = NSDateComponentsFormatter()
		formatter.allowedUnits = NSCalendarUnit.SecondCalendarUnit
		formatter.allowsFractionalUnits = true
		
		XCPCaptureValue("\(name) Average", mean.milliSeconds)
		XCPCaptureValue("\(name) STD Dev.", variance.milliSeconds)
	}
	
	return (mean, totalTook)
}

extension Double{
	
	var milliSeconds : String {
		return String(format: "%03.2fms", self*1000)
	}
	
}