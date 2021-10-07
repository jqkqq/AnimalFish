//
//  SeaFeature.swift
//  AnimalSeaCreatures

import Foundation

typealias Fish = [String: Value]

// MARK: - Value
struct Value: Codable {
    let id: Int
    let name: Name
    let availability: Availability
    let shadow: String
    let price: Int
    let imageURI, iconURI: String

    enum CodingKeys: String, CodingKey {
        case id        
        case name, availability, shadow, price
        case imageURI = "image_uri"
        case iconURI = "icon_uri"
    }
}

// MARK: - Availability
struct Availability: Codable {
    let location: Location?
    let rarity: Rarity?
    let monthArrayNorthern, monthArraySouthern, timeArray: [Int]

    enum CodingKeys: String, CodingKey {
        case rarity, location
        case monthArrayNorthern = "month-array-northern"
        case monthArraySouthern = "month-array-southern"
        case timeArray = "time-array"
    }
}

enum Rarity: String, Codable {
    case common = "Common"
    case rare = "Rare"
    case ultraRare = "Ultra-rare"
    case uncommon = "Uncommon"
}

enum Location: String, Codable {
    case pier = "Pier"
    case pond = "Pond"
    case river = "River"
    case riverClifftop = "River (Clifftop)"
    case riverClifftopPond = "River (Clifftop) & Pond"
    case riverMouth = "River (Mouth)"
    case sea = "Sea"
    case seaWhenRainingOrSnowing = "Sea (when raining or snowing)"
}


// MARK: - Name
struct Name: Codable {
    let nameTWzh: String

    enum CodingKeys: String, CodingKey {
        case nameTWzh = "name-TWzh"
    }
}

extension Name: Hashable { }

extension Rarity {
    func changeToChinese() -> String {
        switch self {
        case .common:
            return "普通"
        case .rare:
            return "稀有"
        case .ultraRare:
            return "非常稀有"
        case .uncommon:
            return "不普通"
        }
    }
}

extension Location {
    func changeToChinese() -> String {
        switch self {
        case .pier:
            return "碼頭"
        case .pond:
            return "池塘"
        case .river:
            return "河流"
        case .riverClifftop:
            return "碼頭"
        case .riverClifftopPond:
            return "山上的池塘"
        case .riverMouth:
            return "山上的河"
        case .sea:
            return "海洋"
        case .seaWhenRainingOrSnowing:
            return "下雨或下雪天"
        }
    }
}

