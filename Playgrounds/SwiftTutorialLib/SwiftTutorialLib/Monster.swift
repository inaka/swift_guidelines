//
//  Monster.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import UIKit

public enum MonsterType : String {
	case Gargoyle = "Gargoyle"
	case Balrog = "Balrog"
	case Shelob = "Shelob"
	case Orc = "Orc"
	case Fairy = "Fairy"
	case Bedbug = "Bedbug"
}

public struct Monster : JSONSerializable {
	public let monsterType : MonsterType
	public let numberOfLegs : Int
	public let skinColor : UIColor
	
	public init(monsterType: MonsterType, numberOfLegs: Int, skinColor: UIColor) {
		self.monsterType = monsterType
		self.numberOfLegs = numberOfLegs
		self.skinColor = skinColor
	}
	
	public init(dictionary: Dictionary<String, AnyObject>) {
		self.monsterType = MonsterType(rawValue: dictionary["monster_type"] as! String)!
		self.numberOfLegs = dictionary["number_of_legs"] as! Int
		if let colorDict = dictionary["color"] as? Dictionary<String, CGFloat> {
			var r = colorDict["r"] as CGFloat!
			var g = colorDict["g"] as CGFloat!
			var b = colorDict["b"] as CGFloat!
			
			self.skinColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
		} else {
			self.skinColor = UIColor.orangeColor()
		}
	}
	
	public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
		var dict = Dictionary<String, AnyObject>()
		dict["monster_type"] = self.monsterType.rawValue
		dict["number_of_legs"] = self.numberOfLegs
		
		var colorDict = Dictionary<String, CGFloat>()
		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 1.0
		
		var success = self.skinColor.getRed(&r, green: &g, blue: &b, alpha: &a)
		
		colorDict["r"] = r
		colorDict["g"] = g
		colorDict["b"] = b
		
		dict["color"] = colorDict
		
		return dict
	}
}