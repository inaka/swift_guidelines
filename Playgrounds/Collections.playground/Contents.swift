/*:

# Collections
*/

import UIKit

/*: 
## Array

*/
/*: Pure Swift arrays are `value` types. Note that copying an array and adding a value to the copy does not alter the original array
*/
var firstArray = ["One", "Two", "Three", "Four"]
var secondArray = firstArray
secondArray.append("Five")
firstArray

/*: Casting pure Swift arrays into NSArrays makes them behave as reference types.
*/

var firstTry: NSMutableArray = (firstArray as NSArray).mutableCopy() as! NSMutableArray
var secondTry = firstTry
secondTry.addObject("Six")
firstTry


/*: NSArrays are `reference` types. Note that copying an NSArray and adding a value to the copy **does** alter the original array
*/
var firstObjectArray = NSMutableArray()
firstObjectArray.addObject("1")
var secondObjectArray = firstObjectArray
secondObjectArray.addObject("2")
firstObjectArray

/*: 
## Dictionary

*/

/*: 
## Tuple

*/
