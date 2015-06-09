//
//  Person.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import Foundation

public struct Person : JSONSerializable, JSONRefreshable {
	public var firstName : String?
	public var lastName : String?
	public var gender : Gender? = Gender.Unknown
	
	public init(firstName: String, lastName: String, gender: Gender) {
		self.firstName = firstName
		self.lastName = lastName
		self.gender = gender
	}
	
	public init(dictionary: Dictionary<String, AnyObject>) {
		self.refreshWithDictionary(dictionary)
	}

	public mutating func refreshWithDictionary(dictionary: Dictionary<String, AnyObject>) {
		self.firstName = dictionary["firstName"] as? String
		self.lastName = dictionary["lastName"] as? String
		self.gender = Gender(rawValue: (dictionary["gender"] as? String)!)
	}
	
	public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
		return Dictionary<String, AnyObject>()
	}
}

public enum Gender : String {
	case Unknown = "U"
	case Male = "M"
	case Female = "F"
}