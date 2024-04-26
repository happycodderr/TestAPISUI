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
        VStack {
            List(viewModel.users) { user in
                VStack{
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
        .task {
            await viewModel.getUsers()
        }
    }
}

#Preview {
    UserListView()
}
