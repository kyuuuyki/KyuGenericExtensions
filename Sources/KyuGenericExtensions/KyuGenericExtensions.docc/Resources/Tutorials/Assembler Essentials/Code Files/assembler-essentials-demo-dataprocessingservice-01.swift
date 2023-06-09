public protocol DataProcessingServiceProtocol {
	func generateUniqueString() -> String
}

struct DataProcessingService: DataProcessingServiceProtocol {
	func generateUniqueString() -> String {
		return UUID().uuidString
	}
}
