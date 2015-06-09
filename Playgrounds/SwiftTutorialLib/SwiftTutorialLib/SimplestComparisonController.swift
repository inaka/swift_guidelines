//
//  SimplestComparisonController.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import Foundation

public class SimplestComparisonController {
	public var allClasses = [SimplestClass]()
	public var allStructs = [SimplestStruct]()
	
	public init(){}
	
	public func createAllClasses(number: Int) {
		for var i=0;i<number;i++ {
			var cls = SimplestClass(firstVariable: i)
			self.allClasses.append(cls)
		}
	}
	
	public func createAllStructs(iterations: Int) {
		for var i=0;i<iterations;i++ {
			var struc = SimplestStruct(firstVariable: i)
			self.allStructs.append(struc)
		}
	}
	
	public func mutateAllClasses() {
		for cls in self.allClasses {
			cls.firstVariable += 1
		}
	}
	public func mutateClassesByCreatingNewClasses() {
		var localClasses = [SimplestClass]()
		for c in self.allClasses {
			var tutClass = SimplestClass(firstVariable: c.firstVariable+1)
			localClasses.append(tutClass)
		}
		self.allClasses = localClasses
	}
	
	public  func mutateAllStructs() {
		var localStructs = [SimplestStruct]()
		for struc in self.allStructs {
			var tutStruct = SimplestStruct(firstVariable: struc.firstVariable+1)
			localStructs.append(tutStruct)
		}
		self.allStructs = localStructs
	}
}

