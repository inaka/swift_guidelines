/*:
Creating Structs vs creating Classes: Performance

You can create structs much quicker than you can create classes.
*/

import Foundation
import SwiftTutorialLib

var iterationNumber = 100

let comparisonController = SimplestComparisonController()

var classMean = measure(name: "Classes", iterations: iterationNumber) {
	comparisonController.createAllClasses(iterationNumber) //1.080059148788452
}
println("Mean for creating classes: ")
println("    \(classMean.mean), total: \(classMean.total)")

var structMean = measure(name: "Structs", iterations: iterationNumber) {
	comparisonController.createAllStructs(iterationNumber) //0.7053990791141986
}
println("Mean for creating Structs: ")
println("    \(structMean.mean), total: \(structMean.total)")

var structMutateMean = measure(name: "Mutating Structs", iterations: iterationNumber) {
	comparisonController.mutateAllStructs() //47.14663217532635
}
println("Mean for mutating structs: )")
println("    \(structMutateMean.mean), total: \(structMutateMean.total)")

var classMutateMean = measure(name: "Mutating classes", iterations: iterationNumber) {
	comparisonController.mutateAllClasses() //399.8379959006905
}
println("Mean for mutating classes in-place: ")
println("    \(classMutateMean.mean), total: \(classMutateMean.total)")

var classInPlaceMutateMean = measure(name: "Mutating classes by creating", iterations: iterationNumber) {
	comparisonController.mutateClassesByCreatingNewClasses() //399.8379959006905
}
println("Mean for mutating classes by creating new instances:")
println("   \(classInPlaceMutateMean.mean), total: \(classInPlaceMutateMean.total)")
