//
//  SeaFeatureDetailViewModel.swift
//  AnimalSeaCreatures


import Foundation
import Combine
import SwiftUI

class FishDetailViewModel: ObservableObject {
    
    @Published var fish: Value
    @Published var isLove = false
    @Published var hide = false
    
    private var cancellables: [AnyCancellable] = []
    private let isLoveSubject = PassthroughSubject<Value, Never>()
    
    init(seaFeature: Value) {
        self.fish = seaFeature
        self.checkIsLove()
    }
    
    func checkNorthMonth(_ month: Int) -> Color {
        let bool = !fish.availability.monthArrayNorthern.filter({
            $0 == month
        }).isEmpty
        return bool ? Color.green: Color.clear
    }
    
    func checkSourthMonth(_ month: Int) -> Color {
        let bool = !fish.availability.monthArraySouthern.filter({
            $0 == month
            }).isEmpty
        return bool ? Color.green: Color.clear
    }
    
    func checkTime(_ hour: Int) -> Color {
        let bool = !fish.availability.timeArray.filter({
            $0 == hour
            }).isEmpty
        return bool ? Color.green: Color.clear
    }
    
    func checkIsLove() {
//        let allData = RealmManager.shared.fetchAll()
//        isLove = !allData.filter({
//            $0.name == seaFeature.name.nameCNzh
//        }).isEmpty
        
        $fish
            .map { (fish) -> Bool in
                guard let allData = FishDataManager.shared.fetchAll() else {
                    return false
                }
                let bool = !allData.filter({
                    $0.name == fish.name.nameTWzh
                }).isEmpty
                return bool
        }
        .assign(to: \.isLove, on: self)
        .store(in: &cancellables)
    }
    
    func addLove() {
        FishDataManager.shared.add(fish)
        isLove = true
    }
    
    func deleteLove() {
        guard let allData = FishDataManager.shared.fetchAll() else {
            return
        }
        guard let deleteSea = allData.filter({
            $0.name == fish.name.nameTWzh
        }).first else { return }        
        FishDataManager.shared.delete(deleteSea)
        isLove = false
        NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil)
    }
    
    
}
