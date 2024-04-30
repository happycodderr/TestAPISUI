
import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = UserListViewModel()
    @State var isAlertPresented = false
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .isLoading:
                    ProgressView()
                case .loaded:
                    loadUserList()
                case .error:
                    showErrorAlert()
                }
            }
            .navigationTitle("Available Users")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.getUsers()
                if viewModel.networkError != nil {
                    isAlertPresented = true
                }
            }
            .refreshable {
                await viewModel.getUsers()
            }
        }
    }
    
    @ViewBuilder
    func loadUserList() -> some View {
        List(viewModel.users) { user in
            NavigationLink(destination: UserDetailsView(user: user)) {
                VStack(alignment: .leading) {
                    Text("UserName: \(user.name)")
                    Text("Email: \(user.email)")
                }
            }
        }
        .searchable(text: $searchText) {
            ForEach(viewModel.users) { user in
                Text(user.name)
            }
        }
        .onChange(of: searchText) {
            oldValue, newValue in
            filterUsers(newValue)
        }
    }
    
    private func filterUsers(_ searchText: String) {
        viewModel.filteredUsers = viewModel.users.filter { user in
            user.name.caseInsensitiveCompare(searchText) == .orderedSame
        }
    }
    
    @ViewBuilder
    func showErrorAlert() -> some View {
        ProgressView()
            .alert(
                isPresented: $isAlertPresented) 
        {
            Alert(
                title: Text("Service Error"),
                message: Text("Data not found"),
                dismissButton: .default(Text("Dismiss"))
            )
        }
    }
}

#Preview {
    UserListView()
}
