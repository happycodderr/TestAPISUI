
import Foundation

protocol Networkable {
    func get(urlString: String) async throws -> [User]
}

class NetworkManager: Networkable {
    var cache = [URL: [User]]()
    
    func get(urlString: String) async throws -> [User] {
        guard let url = URL(string: urlString) else {
            throw NetworkErrors.invalidURL
        }
        if let cachedData = cache[url] {
                   return cachedData
               }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try JSONDecoder().decode([User].self, from: data)
            cache[url] = users
            return users
        } catch {
            throw NetworkErrors.invalidData
        }
    }
}
