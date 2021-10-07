//
//  FishManager.swift
//  AnimalFish


import Foundation
import CoreData

class FishDataManager {
    static let shared = FishDataManager()

    func add(_ fish: Value) {
        if let entity = NSEntityDescription.entity(forEntityName: "FishData",in:CoreDataManager.shared.persistentContainer.viewContext) {
            let fishData = FishData(entity: entity, insertInto: CoreDataManager.shared.persistentContainer.viewContext)
            fishData.name = fish.name.nameTWzh
            fishData.iconURI = fish.iconURI
            fishData.imageURI = fish.imageURI
            fishData.monthArrayNorthern = fish.availability.monthArrayNorthern
            fishData.monthArraySouthern = fish.availability.monthArraySouthern
            fishData.timeArray = fish.availability.timeArray
            fishData.location = fish.availability.location?.changeToChinese() ?? ""
            fishData.rarity = fish.availability.rarity?.changeToChinese() ?? ""
            fishData.price = Int16(fish.price)
            fishData.shadow = fish.shadow
            
            CoreDataManager.shared.saveContext()
        }
    }
    
    func fetchAll() -> [FishData]? {
        let request: NSFetchRequest<FishData> = FishData.fetchRequest()
        ///SQL語法
        do {
            let results = try CoreDataManager.shared.persistentContainer.viewContext.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func delete(_ fish: FishData) {
        CoreDataManager.shared.persistentContainer.viewContext.delete(fish)
        CoreDataManager.shared.saveContext()
    }
}

extension FishData {
    func changeToValue() -> Value {
        
        let value = Value(
            id: 0,
            name: Name(nameTWzh: self.name ?? ""),
            availability: Availability(location:
                                        Location(rawValue: self.location ?? ""),
                                       rarity: Rarity(rawValue: self.rarity ?? ""),
                                       monthArrayNorthern: self.monthArrayNorthern ?? [],
                                       monthArraySouthern: self.monthArraySouthern ?? [],
                                       timeArray: self.timeArray ?? []),
            shadow: self.shadow ?? "",
            price: Int(self.price),
            imageURI: self.imageURI ?? "",
            iconURI: self.iconURI ?? "")
        
        return value
    }
    
    
}
