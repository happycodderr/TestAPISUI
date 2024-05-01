
import Foundation

protocol Networkable {
    func getDataFromAPI<T>(urlString: String, type: T.Type) async throws -> T where T: Codable
}

final class NetworkManager: Networkable {
    
    func getDataFromAPI<T>(urlString: String, type: T.Type) async throws -> T where T: Codable {
        guard let url = URL(string: urlString) else {
            throw NetworkErrors.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            let decodedData = try JSONDecoder().decode(type.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
