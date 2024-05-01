
import Foundation

protocol Networkable {
    func getDataFromAPI<T>(urlString: String, type: T.Type) async throws -> T where T: Codable
}

final class NetworkManager: Networkable {
    
    func getDataFromAPI<T>(urlString: String, type: T.Type) async throws -> T where T: Codable {
        let manager = LocalFileManager.instance
       // var cache = [URL: [type]]
        guard let url = URL(string: urlString) else {
            throw NetworkErrors.invalidURL
        }
//        if let cachedData = cache[url] {
//            print("Cached Data : \(cachedData)")
//                   return cachedData
//               }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            let decodedData = try JSONDecoder().decode(type.self, from: data)
          //  cache[url] = users
            return decodedData
        } catch {
            throw error
        }
    }
}
