
/*
 "id": 1,
 "name": "Leanne Graham",
 "username": "Bret",
 "email": "Sincere@april.biz",
 "address": {
   "street": "Kulas Light",
   "suite": "Apt. 556",
   "city": "Gwenborough",
   "zipcode": "92998-3874",
   "geo": {
     "lat": "-37.3159",
     "lng": "81.1496"
   }
 },
 "phone": "1-770-736-8031 x56442",
 "website": "hildegard.org",
 "company": {
   "name": "Romaguera-Crona",
   "catchPhrase": "Multi-layered client-server neural-net",
   "bs": "harness real-time e-markets"
 }
} */
import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
    
}

struct Address: Codable, Hashable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Codable, Hashable {
    let lat, lng: String
}

struct Company: Codable, Hashable {
    let name, catchPhrase, bs: String
}

extension User {
    static let user = User(id: 1, name: "XYZ", username: "xyzuser", email: "xyz@gmail.com", address: Address(street: "Test Street", suite: "123", city: "Test", zipcode: "AB10 0CV", geo: Geo(lat: "10.0", lng: "10.0")), phone: "01234567890", website: "xyz@website.com", company: Company(name: "XYZCompany", catchPhrase: "You got the best", bs: "XX"))
}
