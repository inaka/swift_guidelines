//
//  JSONSerializable.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import Foundation

public protocol JSONSerializable {
	init(dictionary: Dictionary<String, AnyObject>)
	func dictionaryRepresentation() -> Dictionary<String, AnyObject>
}

public protocol JSONRefreshable {
	mutating func refreshWithDictionary(dictionary: Dictionary<String, AnyObject>)
}