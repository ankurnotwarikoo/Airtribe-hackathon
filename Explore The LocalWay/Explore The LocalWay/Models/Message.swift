import Foundation

struct Message: Hashable {
    var id = UUID()
    var content: String
    var isCurrentUser: Bool
}

struct DataSource {
    
    static let messages = [
        
        Message(content: "Hi there, Welcome to Explore the localWay!", isCurrentUser: false),
      
    ]
}
