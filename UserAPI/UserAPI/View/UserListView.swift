
import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = UserListViewModel()
    @State var isAlertPresented = false
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
