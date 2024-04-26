
import Foundation

protocol Networkable {
    func get(urlString: String) async throws -> [User]
}

class NetworkManager: Networkable {
    func get(urlString: String) async throws -> [User] {
        guard let url = URL(string: urlString) else {
            throw NetworkErrors.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([User].self, from: data)
        } catch {
            throw NetworkErrors.invalidData
        }
    }
}
