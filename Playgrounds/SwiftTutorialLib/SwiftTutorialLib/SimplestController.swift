//
//  SimplestController.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import Foundation

public class SimplestController {
	public let firstClass : SimplestClass
	public let firstStruct : SimplestStruct
	public var secondStruct : SimplestStruct?
	
	public init() {
		self.firstClass = SimplestClass(firstVariable: 1)
		self.firstStruct = SimplestStruct(firstVariable: 1)
	}
}