//
// Calls a particular block the specified number of times, returning the average
// number of seconds it took to complete the code. If a name is supplied the time
// take for each iteration will be recorded
//

import Foundation
import XCPlayground

public typealias MeasuredBlock = ()->Void

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