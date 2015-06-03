import UIKit
/*:
# Learning Swift
## Classes and Structs

*/
/*:
### Classes are **Reference Types**
*/
var classTest = TutorialClass(firstVariable: 0)
var classTest2 = classTest
classTest.firstVariable
classTest2.firstVariable

classTest.firstVariable = 1
//: Note that both `classTest.firstVariable` and `classTest2.firstVariable' both have the **changed** value (**1**)
classTest.firstVariable
classTest2.firstVariable

/*:
### Structs are **Value Types** 
*/
var structTest = TutorialStruct(firstVariable: 0)
var structTest2 = structTest
structTest.firstVariable
structTest2.firstVariable

structTest.firstVariable = 2

//: Note that both `structTest.firstVariable` and `structTest2.firstVariable' both have **different** values (**2** and **0**)
structTest.firstVariable
structTest2.firstVariable

//: Using them
var tutorialController = TutorialController()
tutorialController.firstClass
tutorialController.firstStruct
/*:
`firstClass` and `firstStruct` are declared as **constants** (using the `let` keyword).

Note how you can change the value of `firstClass.firstVariable`, but you cannot for `firstStruct.firstVariable`.
*/

tutorialController.firstClass.firstVariable = 3
//: Uncomment these lines to see the errors.
//tutorialController.firstStruct.firstVariable = 3 //Error: Cannot assign to the result of this expression
//tutorialController.firstStruct.changeFirstVariable(3) //Error: Immutable value of type 'TutorialStruct' only has mutating members named 'changeFirstVariable'

/*:
`secondStruct` is declared as a **variable** (using the `var` keyword) and now you can change its value
*/
tutorialController.secondStruct = tutorialController.firstStruct
tutorialController.secondStruct!.firstVariable = 4
/*: 
`changeFirstVariable` must be declared as a `mutating func`.

    public mutating func changeFirstVariable(newVal : Int) {
        self.firstVariable = newVal
    }
*/
tutorialController.secondStruct!.changeFirstVariable(5)
tutorialController.secondStruct

var outsideTutorialClass = tutorialController.firstClass
outsideTutorialClass.firstVariable = 7
tutorialController.firstClass

//: `===` is the identity operator. This does not just test if the instances being compared are *equal*, but also that they are *identical* (that is, the same things). Note that `===` throws an error when used with `Structs`.

outsideTutorialClass === tutorialController.firstClass

var outsideFirstStruct = tutorialController.firstStruct
/*: 
In order for `==` to work with structs, the `==` operator must be overridden **outside** of the struct itself:

    public func ==(lhs: TutorialStruct, rhs: TutorialStruct) -> Bool {
        return lhs.firstVariable == rhs.firstVariable
    }
Because the override is Type-Specific (note the `lhs: TutorialStruct`), multiple overrides of `==` are possible, and indeed necessary -- each override specific to the class or struct.
*/
outsideFirstStruct == tutorialController.secondStruct!
outsideFirstStruct == tutorialController.firstStruct

tutorialController.secondStruct!.changeFirstVariable(tutorialController.firstStruct.firstVariable)
var outsideFirstStruct2 = tutorialController.firstStruct
outsideFirstStruct2 == tutorialController.secondStruct!
outsideFirstStruct2 == tutorialController.firstStruct

/*:
## View the `ClassesStructsPerformance.playground` file to see relative performance
*/


