//
//  Porpoise.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import Foundation

public struct Porpoise : JSONSerializable {
	public var firstname: String!
	
	public init() {}
	public init(firstname: String) {
		self.firstname = firstname
	}
	
	public static func load() -> Porpoise {
		if let dict = NSUserDefaults.standardUserDefaults().objectForKey("SavedUser") as? Dictionary<String, AnyObject> {
			var firstname = dict["firstname"] as! String
			var person = Porpoise(firstname: firstname)
			
			return person
		} else if let data = NSUserDefaults.standardUserDefaults().objectForKey("SavedUser") as! NSData?, dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String : AnyObject] {
			var firstname = dict["firstname"] as! String
			var person = Porpoise(firstname: firstname)
			
			return person
		} else {
			var porpoise = Porpoise()
			porpoise.firstname = "Unknown"
			return porpoise
		}
	}
	public static func save(user: Porpoise) {
		NSUserDefaults.standardUserDefaults().setObject(user.dictionaryRepresentation(), forKey: "SavedUser")
		NSUserDefaults.standardUserDefaults().synchronize()
	}
	
	//MARK: JSONSerializable
	public init(dictionary: Dictionary<String, AnyObject>) {
		self.firstname = dictionary["firstname"] as! String
	}
	
	public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
		var dict = Dictionary<String, AnyObject>()
		dict["firstname"] = self.firstname
		
		return dict
	}
}