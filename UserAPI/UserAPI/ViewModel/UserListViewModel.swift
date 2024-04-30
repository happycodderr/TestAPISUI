
import Foundation

enum ViewState {
    case isLoading
    case loaded
    case error
}

@MainActor
class UserListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var viewState: ViewState = .isLoading
    @Published var networkError: NetworkErrors?
    @Published var filteredUsers: [User] = []
    private var manager: Networkable

    init(manager: Networkable = NetworkManager()) {
        self.manager = manager
    }
    
    func getUsers() async {
        do {
            viewState = .isLoading
            users = try await manager.get(urlString: APIEndPoint.usersEndPoint)
            viewState = .loaded
        } catch {
            print(error)
            switch networkError {
            case .invalidURL:
                networkError = .invalidURL
            case .invalidData:
                networkError = .invalidData
            case nil:
                break
            }
            viewState = .error
        }
    }
}
