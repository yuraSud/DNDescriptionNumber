
import Foundation

public struct NumberModel: Codable {
    
    var text: String?
    var year: Int?
    var number: Int?
    var found: Bool?
    var type: String?
    
    var typeRequest: TypeRequest?
}
