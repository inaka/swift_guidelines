//
//  PersonClass.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import Foundation
class PersonClass {
	var firstName : String?
	var lastName : String
	var gender : Gender = Gender.Unknown
	
	init(firstName: String, lastName: String, gender: Gender) {
		self.firstName = firstName
		self.lastName = lastName
		self.gender = gender
	}
}