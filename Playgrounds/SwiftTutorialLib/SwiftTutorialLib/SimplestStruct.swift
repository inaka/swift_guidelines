//
//  SimplestStruct.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import Foundation

public  struct SimplestStruct {
	public var firstVariable : Int
	
	public init(firstVariable: Int) {
		self.firstVariable = firstVariable
	}
	
	public mutating func changeFirstVariable(newVal : Int) {
		self.firstVariable = newVal
	}
}

public func ==(lhs: SimplestStruct, rhs: SimplestStruct) -> Bool {
	return lhs.firstVariable == rhs.firstVariable
}