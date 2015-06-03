import Foundation

public struct VehicleUser {
	public let name : String
	public var license : String
	
	public init(name: String, license: String) {
		self.name = name
		self.license = license
	}
}

public struct Vehicle {
	public let model: String
	
	public init(model: String) {
		self.model = model
	}
}

