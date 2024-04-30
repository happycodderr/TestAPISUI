
import Foundation

enum ViewState {
    case isLoading
    case loaded
    case error
}

final class UserListViewModel: ObservableObject {
    @Published var viewState: ViewState = .isLoading
    @Published var networkError: NetworkErrors?
    @Published var filteredUsers: [User] = []
    private var manager: Networkable
    private var users: [User] = []

    init(manager: Networkable = NetworkManager()) {
        self.manager = manager
    }
    
    @MainActor
    func getUsers() async {
        do {
            viewState = .isLoading
            users = try await manager.getDataFromAPI(urlString: APIEndPoint.usersEndPoint, type: [User].self)
            filteredUsers = users
            viewState = .loaded
        } catch {
            print(error)
            switch networkError {
            case .invalidURL:
                networkError = .invalidURL
            case .invalidData:
                networkError = .invalidData
            case nil:
                networkError = .invalidData
            }
            viewState = .error
        }
    }
    func filterUsers(_ searchText: String) {
        if searchText.isEmpty {
            self.filteredUsers = self.users.sorted(by: { $0.name < $1.name })
        } else {
            let list = self.users.filter { user in
                return user.name.localizedCaseInsensitiveContains(searchText)
            }
            self.filteredUsers = list.sorted(by: { $0.name < $1.name })
        }
    }
}
