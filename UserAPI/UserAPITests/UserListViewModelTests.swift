
import XCTest
@testable import UserAPI

final class UserListViewModelTests: XCTestCase {
    var sut: UserListViewModel!
    
    override func setUp() async throws {
        sut = UserListViewModel(manager: MockNetworkManager())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_getUserList_Success() async {
        //Given
        
        //When
        await sut.getUsers(urlString: "UserTest")
        
        //Then
        XCTAssertEqual(sut.users.count, 10)
        XCTAssertEqual(sut.users.first?.name, "Leanne Graham")
    }
    
//    func test_getUserList_Failure() async {
//        //Given
//        
//        //When
//        await sut.getUsers(urlString: "asfd")
//        
//        //Then
//        //XCTAssertEqual(sut.users.count, 0)
//        XCTAssertNotNil(sut.networkError)
//    }
}

final class MockNetworkManager: Networkable {
    func getDataFromAPI<T>(urlString: String, type: T.Type) async throws -> T where T : Codable {
        let bundle = Bundle(for: MockNetworkManager.self)
        let fileURL = bundle.url(forResource: urlString, withExtension: "json")
        guard let fileURL = fileURL else { throw NetworkErrors.invalidURL }
        do {
            let data = try Data(contentsOf: fileURL)
            let users = try JSONDecoder().decode(type.self, from: data)
            return users
        } catch {
            throw error
        }
    }

}
