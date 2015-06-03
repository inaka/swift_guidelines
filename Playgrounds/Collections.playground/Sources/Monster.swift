import UIKit

public enum MonsterType : String {
	case Gargoyle = "Gargoyle"
	case Balrog = "Balrog"
	case Shelob = "Shelob"
	case Orc = "Orc"
	case Fairy = "Fairy"
	case Bedbug = "Bedbug"
}

public struct Monster {
	public let monsterType : MonsterType
	public let numberOfLegs : Int
	public let skinColor : UIColor
	
	public init(monsterType: MonsterType, numberOfLegs: Int, skinColor: UIColor) {
		self.monsterType = monsterType
		self.numberOfLegs = numberOfLegs
		self.skinColor = skinColor
	}
}