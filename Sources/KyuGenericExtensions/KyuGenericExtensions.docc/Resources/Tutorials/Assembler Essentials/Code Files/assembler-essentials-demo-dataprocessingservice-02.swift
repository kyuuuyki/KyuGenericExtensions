public protocol DataProcessingServiceProtocol: ModuleProtocol {
	func generateUniqueString() -> String
}

struct DataProcessingService: DataProcessingServiceProtocol {
	static var moduleName: String = "AssemblerDemo.DataProcessingService"
	
	func generateUniqueString() -> String {
		return UUID().uuidString
	}
}
