
import Foundation

public struct NumberModel: Codable {
    
    public var text: String?
    var year: Int?
    var number: Int?
    var found: Bool?
    var type: String?
    
    var typeRequest: TypeRequest?
}
