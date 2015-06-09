import UIKit

/*: 
# Functions and Closures
*/

/*:
## Deconstructing Function Parameters and Anonymous Closures

(cribbed from https://www.weheartswift.com/higher-order-functions-map-filter-reduce-and-more/
 )*/
//: Base Examples
func square(a: Float) -> Float {
	return a * a
}

square(3.0)

func cube(a: Float) -> Float {
	return a * a * a
}

cube(3.0)

func averageSumOfSquares(a: Float, b: Float) -> Float {
	return (square(a) + square(b)) / 2.0
}

averageSumOfSquares(3.0, 12.0)

func averageSumOfCubes(a: Float, b: Float) -> Float {
	return (cube(a) + cube(b)) / 2.0
}

averageSumOfCubes(3.0, 12.0)

/*:
Instead of calling `square` or `cube`, we can create a function that takes a function as a parameter.

`f:(Float -> Float)` is saying "This function 'f' takes a parameter of type 'Float' and returns a 'Float'"
*/

func averageOfFunction(a: Float, b: Float, f:(Float -> Float)) -> Float {
	return (f(a) + f(b)) / 2.0
}

averageOfFunction(3, 12, square)
averageOfFunction(3, 3, cube)

/*:
But since we know the signature accepts a function as the 3rd parameter, we can also pass in an anonymous closure to act as that 3rd parameter.
*/

var z = averageOfFunction(3, 12, {(x: Float) -> Float in return x * x})
z

//: Let's simplify that closure. We don't need the type declaration since that can be inferred.
z = averageOfFunction(3, 12, {x in return x * x})
z

//: Let's simplify further. We don't need to specify the return value. 
z = averageOfFunction(3, 12, {x in x * x})
z

//: Finally, we can omit the parameter names and use the default parameter name `$0`. If there is more than one parameter, just increment it (`$1	, etc).
z = averageOfFunction(3, 12, {$0 * $0})
z



/*:
# Map

We're used to iterating through elements of an array in order to transform each element in the array into something else. `map` simplifies that for us.
*/

//: The way we're used to doing it:
var numberArray = [1, 2, 3, 4, 5, 10, 24, 55, 999]

var moneyArray : [String] = []

for num in numberArray {
	moneyArray.append("$\(num) US")
}
moneyArray

//: Let's do the same thing using `map`:
var newMoneyArray = numberArray.map { num in "$\(num) US"}
newMoneyArray

/*:
# Filter

Creating a new array where elements of the old array meet a condition.
*/

//: The old way
var filterArray : [Int] = []
for num in numberArray {
	if num > 30 {
		filterArray.append(num)
	}
}
filterArray

//: using filter
var newFilterArray = numberArray.filter { $0 > 30 }
newFilterArray

/*:
# Reduce

Combining elements of an array into a single value
*/

//: Old way
var sum = 0

for num in numberArray {
	sum += num
}
sum

//: New way
sum = numberArray.reduce(0,combine: { $0 + $1 })
sum

//: Even shorter
sum = numberArray.reduce(0,combine: +)

