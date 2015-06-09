/*:
# Learning Swift

## The power of Enums
*/

import UIKit

//: Plain Enum

enum Direction {
	case North, South, East, West
}
var myDirection = Direction.North

//: Enum with a type and a value
enum DirectionString : String {
	case North = "North"
	case South = "South"
	case East = "East"
	case West = "West"
}

var myStringDirection = DirectionString.North
myStringDirection.rawValue

//: Enum with Associated Values
enum CustomDirection {
	case North(Direction, DirectionString)
	case South(Direction, DirectionString)
	case East(Direction, DirectionString)
	case West(Direction, DirectionString)
}

let myCustomDirection = CustomDirection.North(Direction.North, DirectionString.North)

switch myCustomDirection {
case CustomDirection.North(_, let y):
	println("Hey, it's \(y.rawValue)")
default:
	println("Didn't find north")
}

struct Personage {
	var firstName : String
	let lastName : String
}

var tom = Personage(firstName: "Tom", lastName: "Sawyer")
var dick = Personage(firstName: "Dick", lastName: "Tracy")
var harry = Personage(firstName: "Harry", lastName: "Houdini")

enum PersonableDirection {
	case North(Direction, Personage?)
}

var tomDirection = PersonableDirection.North(Direction.North, tom)

switch tomDirection {
case PersonableDirection.North(_, let person):
	println(person!.firstName)
}

/*:
## Example of use in a UITableView

Here is the main enum. Note each case as an associated type, including one optional (there won't always be a co-driver
*/
public enum ConveyanceItem {
	case Driver(VehicleUser)
	case CoDriver(VehicleUser?)
	case Powerunit(Vehicle)
	case Trailer(Vehicle?)
}

extension ConveyanceItem {
	var omitCodriver : Bool {
		switch self {
		case .CoDriver(let val):
			if let driver = val {
				return true
			} else {
				return false
			}
		case .Trailer(let val) :
			if let trailer = val {
				return true
			} else {
				return false
			}
			default: return true
		}
	}
}
/*:
#### Here is the tableview's data source.

The client requirements were to always show all 4 Conveyance items (Driver, CoDriver, Powerunit, and Trailer as section headers, even if there were no values.
*/
public class DriverDataSource : NSObject, UITableViewDataSource {
	public override init() {
		super.init()
		self.createConveyanceItems()
	}
	
	public var conveyanceItems = [ConveyanceItem]()
	
	public func createConveyanceItems() {
		var driver = VehicleUser(name: "Fred Baxter", license: "12345")
		var powerUnit = Vehicle(model: "Ford")
		var trailer = Vehicle(model: "Trailer thingie")
		
		self.conveyanceItems.append(ConveyanceItem.Driver(driver))
		//Note that the CoDriver's associated value is `nil`
		self.conveyanceItems.append(ConveyanceItem.CoDriver(nil))
		self.conveyanceItems.append(ConveyanceItem.Powerunit(powerUnit))
		self.conveyanceItems.append(ConveyanceItem.Trailer(nil))
	}
	
	public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return self.conveyanceItems.count
	}
	
	public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
		var item = self.conveyanceItems[indexPath.section]

		var cellText = ""
		
		switch item {
		case ConveyanceItem.Driver(let mainDriver):
			cellText = mainDriver.name
		case ConveyanceItem.CoDriver(let driver):
			if let codriver = driver {
				cellText = codriver.name
			} else {
				cellText = "There isn't a co-driver this time"
			}
		case ConveyanceItem.Powerunit(let vehicle):
			cellText = vehicle.model
		case ConveyanceItem.Trailer(let vehicle):
			if let v = vehicle {
				cellText = v.model
			} else {
				cellText = "Ain't no trailer"
			}
		default:
			break
		}
		cell.textLabel?.text = cellText
		return cell
	}
	
	public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let item = self.conveyanceItems[section]

		switch item {
		case .Driver:
			return "Driver"
		case .CoDriver:
			return "Co-Driver"
		case .Powerunit:
			return "Power Unit"
		case .Trailer:
			return "Trailer"
		}
	}
}

/*:
If, instead, we wanted to omit from the array the values that didn't have associated values, we filter
*/
public class CodriverlessDataSource : DriverDataSource {
	public override func createConveyanceItems() {
		super.createConveyanceItems()
		self.conveyanceItems = self.conveyanceItems.filter { $0.omitCodriver }
	}
}

let dataSource = DriverDataSource()

let table = UITableView(frame: CGRectMake(0, 0, 500, 400), style: UITableViewStyle.Plain)
table.dataSource = dataSource
table.reloadData()

let coLessDataSource = CodriverlessDataSource()
table.dataSource = coLessDataSource
table.reloadData()
