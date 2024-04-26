
import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    private var manager: Networkable
    @Published var users: [User] = []

    init(manager: Networkable = NetworkManager()) {
        self.manager = manager
    }
    
    func getUsers() async {
        do {
            users = try await manager.get(urlString: APIEndPoint.usersEndPoint)
        } catch {
            print(error)
        }
    }
}
