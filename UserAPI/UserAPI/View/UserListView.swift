//
//  UserListView.swift
//  UserAPI
//
//  Created by Geethanjali on 26/04/2024.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = UserListViewModel()
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.users, id: \.self) { user in
                        NavigationLink(destination: UserDetailsView(user: user)) {
                            VStack {
                                HStack {
                                    Text("UserName:")
                                    Text(user.name)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Email:")
                                    Text(user.email)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .navigationTitle("Available Users")
                }
            }
            .task {
                await viewModel.getUsers()
        }
        }
    }
}

#Preview {
    UserListView()
}
