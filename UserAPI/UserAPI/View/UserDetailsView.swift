//
//  UserDetailsView.swift
//  UserAPI
//
//  Created by Geethanjali on 26/04/2024.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            Text("User Details")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer().frame(height: 50)
            HStack {
                Text("User Name: ")
                Text(user.name)
                Spacer()
            }
            
            HStack {
                Text("Email: ")
                Text(user.email)
                Spacer()
            }
            
            HStack {
                Text("Phone: ")
                Text(user.phone)
                Spacer()
            }
            
            HStack {
                Text("Website: ")
                Text(user.website)
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 50)
    }
}

#Preview {
    UserDetailsView(user: User.user)
}
