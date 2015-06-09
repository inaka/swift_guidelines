//
//  StateManager.swift
//  SwiftTutorialLib
//
//  Created by Tom Ryan on 6/4/15.
//  Copyright (c) 2015 Inaka Networks. All rights reserved.
//

import Foundation

public class StateManager {
	public var people = [Person]()
	
	
	
	// MARK: Singleton
	public class var manager : StateManager {
		struct Static {
			static var instance : StateManager?
			static var token : dispatch_once_t = 0
		}
		
		dispatch_once(&Static.token) {
			Static.instance = StateManager()
		}
		
		return Static.instance!
	}
}