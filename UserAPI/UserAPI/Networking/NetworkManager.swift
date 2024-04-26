
import Foundation

protocol Networkable {
    func get(urlString: String) async throws -> [User]
}

class NetworkManager: Networkable {
    func get(urlString: String) async throws -> [User] {
        []
    }
}
