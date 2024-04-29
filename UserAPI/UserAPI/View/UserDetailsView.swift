
import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    var body: some View {
        
        ScrollView {
            Text("User Details View")
                .font(.title)
                .fontWeight(.bold)
            Divider()
            Spacer().frame(height: 30)
            VStack(alignment: .leading, spacing: 10) {
                Text("User Name: \(user.name)")
                Text("Email: \(user.email)")
                Text("Phone: \(user.phone)")
                addressView
                companyView
                Spacer()
            }
        }
        .padding(.top, 50)
    }
    
    var addressView: some View {
        VStack {
            HStack {
                Text("Address: \(user.address.suite),")
                Text("\(user.address.street),")
                Text("\(user.address.city)")
                Text("\(user.address.zipcode)")
            }
        }
    }
    
    var companyView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text("Company: \(user.company.name)")
                Text("\(user.company.catchPhrase)")
            }
            Text("Website: \(user.website)")
        }
    }
}

#Preview {
    UserDetailsView(user: User.user)
}
