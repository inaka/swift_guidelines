/*:

# Collections
*/

import UIKit
import SwiftTutorialLib

/*: 
## Array

*/
/*: 
Pure Swift arrays are `value` types. Note that copying an array and adding a value to the copy does not alter the original array
*/
var firstArray = ["One", "Two", "Three", "Four"]
var secondArray = firstArray
secondArray.append("Five")
firstArray

/*: 
Casting pure Swift arrays into NSArrays makes them behave as reference types.
*/

var firstTry: NSMutableArray = (firstArray as NSArray).mutableCopy() as! NSMutableArray
var secondTry = firstTry
secondTry.addObject("Six")
firstTry


/*: 
NSArrays are `reference` types. Note that copying an NSArray and adding a value to the copy **does** alter the original array
*/
var firstObjectArray = NSMutableArray()
firstObjectArray.addObject("1")
var secondObjectArray = firstObjectArray
secondObjectArray.addObject("2")
firstObjectArray

/*:
### Operations on Arrays
*/
var monsters = [
	Monster(monsterType: MonsterType.Balrog, numberOfLegs: 4, skinColor: UIColor.blackColor()),
	Monster(monsterType: MonsterType.Gargoyle, numberOfLegs: 4, skinColor: UIColor.darkGrayColor()),
	Monster(monsterType: MonsterType.Shelob, numberOfLegs: 8, skinColor: UIColor.blackColor()),
	Monster(monsterType: MonsterType.Orc, numberOfLegs: 2, skinColor: UIColor.blackColor())
]

/*:
#### Reduce
If, for some reason we want to know exactly how many legs were after us, we'd use `reduce`

In the following example
* the `0` value in `mosters.reduce(0)` is just telling `reduce` what you want your initial value to be.
* the `$0` placeholder value is just keeping track of the running total
* the `$1` placeholder value is the current monster in the `monsters` array.

*/
var totalLegs = monsters.reduce(0) { return $0 + $1.numberOfLegs }
totalLegs

/*: 
#### Map

Say we wanted a complete list of all the types monsters chasing us. `Map` is our friend:
*/

var monsterTypes = monsters.map { $0.monsterType.rawValue }
monsterTypes

/*: Flatmap

Say we have a mixed array (like an array inside an array):
*/
var myMixedArray = [["a", "b", "c"], ["d", "e"], ["f", "g", "h"]]
var myFlattenedArray = myMixedArray.flatMap { $0 }
myFlattenedArray

/*:
Or you can append items to the unflattened array before flattening it:
*/
var myXedArray = myMixedArray.flatMap { $0 + ["XX"] }
myXedArray

/*:
#### Map and Filter
Or if we wanted a list of monsters who had 4 legs, we can combine `filter` and `map` into one line.
*/
var monstersWith4Legs = monsters.filter { $0.numberOfLegs == 4 }.map { $0.monsterType.rawValue }
//var newMonsterTypes = monstersWith4Legs.map { $0.monsterType.rawValue }
monstersWith4Legs
/*: 
## Dictionary

*/

/*: 
## Tuple

*/
