import Foundation

class GreetingPreference: Codable {
    
    //MARK: Properties
    var id: Int? = 0
    var type: GreetingType!
    var isActive: Bool = true
    var from: Date!
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case GreetingType = "type"
        case IsActive = "is_active"
        case From = "from"
    }
    
    //MARK: Initializers    
    init(type: GreetingType, isActive: Bool, from: Date) {
        self.type = type
        self.isActive = isActive
        self.from = from
    }
    
    //MARK: Codable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { self.id = try values.decode(Int.self, forKey: .Id) } catch { self.id = nil }
        
        do {
            let type = try values.decode(Int.self, forKey: .GreetingType)
            self.type = type == 1 ? GreetingType.GoodMorning : type == 2 ? GreetingType.GoodAfternoon : type == 3 ? GreetingType.GoodEvening : GreetingType.GoodDawn
        } catch {
            self.type = .GoodMorning
        }
        
        self.isActive = try values.decode(Bool.self, forKey: .IsActive)
        let fromString = try values.decode(String.self, forKey: .From)
        self.from = Parser.shared.stringToDate(fromString, format: "yyyy-MM-dd HH:mm")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .Id)
        try container.encode(self.type.rawValue, forKey: .GreetingType)
        try container.encode(self.isActive, forKey: .IsActive)
        try container.encode(Parser.shared.dateToString(self.from!, format: "yyyy-MM-dd HH:mm"), forKey: .From)
    }
    
}

