
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
            .navigationTitle("Users List")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await makeAPICall()
            }
            .refreshable {
                await makeAPICall()
            }
        }
    }
    
    func makeAPICall() async {
        await viewModel.getUsers(urlString: APIEndPoint.usersEndPoint)
        if viewModel.networkError != nil {
            isAlertPresented = true
        }
    }
    
    @ViewBuilder
    func loadUserList() -> some View {
        List(viewModel.filteredUsers) { user in
            NavigationLink(destination: UserDetailsView(user: user)) {
                VStack(alignment: .leading) {
                    Text("Name: \(user.name)")
                    Text("Email: \(user.email)")
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) {
            newValue in
            viewModel.filterUsers(newValue)
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
